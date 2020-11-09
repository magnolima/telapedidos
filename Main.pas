// 2020 Magno Lima - lima.magno@gmail.com
// Teste de Conhecimento Delphi
// Proposta: Tela de Pedido de Vendas
// ** Parte da base dados de livros infantis FTD
// https://ftd.com.br/wp-content/uploads/2012/07/Tabela-de-pre%C3%A7o-00213.zip
//
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls, System.Types, Datasnap.DBClient;

const
  P_QUERY_CODIGO = 0;
  P_PARAM_CODIGO = 1;
  P_QUERY_NOME = 2;
  P_PARAM_NOME = 3;
  P_DIGITADO = 4;

type
  TPedidoDeVendas = class(TForm)
    GroupBox1: TGroupBox;
    btIncluir: TButton;
    btCancelar: TButton;
    DataSource1: TDataSource;
    PageControl1: TPageControl;
    tsCliente: TTabSheet;
    tsPedido: TTabSheet;
    tsFechamento: TTabSheet;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edProduto: TEdit;
    btIncluirProduto: TButton;
    gbProduto: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    edCliente: TEdit;
    dgCliente: TDBGrid;
    Button2: TButton;
    DataSource2: TDataSource;
    GroupBox3: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label6: TLabel;
    dgItem: TDBGrid;
    DataSource3: TDataSource;
    mtItemProduto: TFDMemTable;
    mtItemProdutoCodigo: TIntegerField;
    mtItemProdutoDescricao: TStringField;
    mtItemProdutoPreco: TFloatField;
    lbTotal: TLabel;
    mtItemProdutoQuantidade: TIntegerField;
    mtItemProdutoTotal: TFloatField;
    GroupBox4: TGroupBox;
    lbTotalFinal: TLabel;
    DBGrid1: TDBGrid;
    btFecharPedido: TButton;
    procedure btCancelarClick(Sender: TObject);
    procedure edClienteEnter(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edProdutoChange(Sender: TObject);
    procedure btIncluirProdutoClick(Sender: TObject);
    procedure mtItemProdutoQuantidadeChange(Sender: TField);
    procedure dgItemKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btFecharPedidoClick(Sender: TObject);
  private
    procedure controlesUICliente(const Habilitado: Boolean);
    procedure LocalizarEmQuery(const Query: TFDQuery;
      Parametros: TStringDynArray);
    procedure IncluirProduto(const Quantidade: Integer);
    procedure MostraTotal;
    function FecharPedido:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PedidoDeVendas: TPedidoDeVendas;
  qryCliente: TFDQuery;
  qryProduto: TFDQuery;
  TotalPedido: Single;

implementation

uses
  System.Character, DataModule;

{$R *.dfm}

procedure TPedidoDeVendas.controlesUICliente(const Habilitado: Boolean);
begin
  TotalPedido := 0;

  if Habilitado then
  begin
    tsCliente.Enabled := True;
    btCancelar.Enabled := True;
    btIncluir.Enabled := False;
    edCliente.SetFocus;
    Exit;
  end;

  tsCliente.Enabled := False;
  qryCliente.Close;
  edCliente.Clear;
  btCancelar.Enabled := False;
  btIncluir.Enabled := True;
  PageControl1.ActivePage := tsCliente;

end;

procedure TPedidoDeVendas.dgItemKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_DELETE then
   begin
      if MessageDlg('Excluir item "'+mtItemProdutoDescricao.AsString +'" ?', mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        mtItemProduto.Delete;
        mtItemProduto.ApplyUpdates;
        MostraTotal();
      end;
   end;

end;

procedure TPedidoDeVendas.FormShow(Sender: TObject);
begin

  if Self.Tag = 1 then
    Exit;

  Self.Tag := 1;

  if not OpenDatabase() then
  begin
    MessageDlg('Arquivo de configuração não encontrado', mtWarning, [mbOK], 0);
    Close;
    Exit;
  end;

  // Iniciar queries de runtime
  // Ideal seria colocar estas queries como generic list aqui TObjectList<TmyQuery> para
  // liberar tudo no final
  criarQuery(qryCliente, '', DataSource1);
  criarQuery(qryProduto, '', DataSource2);

  controlesUICliente(False);
end;

procedure TPedidoDeVendas.btCancelarClick(Sender: TObject);
begin
  if MessageDlg('Cancelar entrada de pedido?', mtWarning, [mbYes, mbNo], 0) = mrYes then
    controlesUICliente(False);
end;

procedure TPedidoDeVendas.btIncluirClick(Sender: TObject);
begin
  controlesUICliente(True);
end;

procedure TPedidoDeVendas.btIncluirProdutoClick(Sender: TObject);
var
  sQuantidade: String;
begin

  sQuantidade := '';

  if InputQuery('Informe a quantidade', 'Quantidade', sQuantidade) then
    if System.Char.IsNumber(sQuantidade, 0) then
    begin
      IncluirProduto(sQuantidade.ToInteger);
      edProduto.Clear;
      edProduto.SetFocus;
    end;

end;

procedure TPedidoDeVendas.IncluirProduto(const Quantidade: Integer);
begin
  mtItemProduto.Active := True;
  mtItemProduto.InsertRecord([qryProduto.FieldByName('codigo').AsInteger,
                        qryProduto.FieldByName('descricao').AsString,
                        qryProduto.FieldByName('preco').AsFloat,
                        quantidade,
                        qryProduto.FieldByName('preco').AsFloat * quantidade]);
  mtItemProduto.Append;
  mtItemProduto.ApplyUpdates();
  TotalPedido := TotalPedido + quantidade * qryProduto.FieldByName('preco').AsFloat * quantidade;
  MostraTotal();

end;

const
     C_TOTAL = 4;

procedure TPedidoDeVendas.MostraTotal;
var
   I: Integer;
begin

  if not mtItemProduto.Active then
     Exit;

  TotalPedido := 0;
  // Perdão aqui, não tive tempo de fazer de forma decente :/
  for I := 1 to Datasource3.Dataset.Recordcount  do
     TotalPedido := TotalPedido + dgItem.Columns.Items[C_TOTAL].Field.AsFloat;

  lbTotal.Caption :=  Format('Total Pedido: R$ %0.2f',[TotalPedido]);
  lbTotalFinal.Caption := lbTotal.Caption;
end;

procedure TPedidoDeVendas.btFecharPedidoClick(Sender: TObject);
var
   pedido : Integer;
begin
   pedido := FecharPedido();

   if pedido = 0 then
      MessageDlg('Erro ao incluir pedido!', mtError, [mbAbort], 0)
   else
      MessageDlg('Pedido #'+ pedido.ToString + ' finalizado com sucesso', mtInformation, [mbOK], 0);

   controlesUICliente(False);
end;

function TPedidoDeVendas.FecharPedido:Integer;
var
   qry: TFDQuery;
   CodigoPedido: Integer;
begin
   // faltou tempo para um try except e outras consistências
   criarQuery(qry,'');
   try
      try
        // cabecalho do pedido
        DM.DBConnection.StartTransaction;

        FormatSettings.DecimalSeparator := '.';
        qry.SQL.Text := 'insert into pedido (CodigoCliente,DataHora) values ('+qryCliente.FieldByName('codigo').AsString+',now());';
        qry.ExecSQL;
        qry.Close;
        qry.SQL.Text := 'select LAST_INSERT_ID() as CodigoPedido';
        qry.Open;
        CodigoPedido := qry.FieldByName('CodigoPedido').AsInteger;

        // itens do pedido
        qry.Close;
        qry.SQL.Clear;
        mtItemProduto.First;
        // temos como fazer isso de forma mais rapida
        while not mtItemProduto.Eof do
        begin
          qry.SQL.Add(Format('INSERT INTO pedido_item (CodigoPedido,CodigoProduto,Quantidade,PrecoUnitario) VALUES(%d, %d, %d, %f);',
            [ CodigoPedido, mtItemProdutoCodigo.AsInteger, mtItemProdutoQuantidade.AsInteger, mtItemProdutoPreco.AsFloat ]));
          mtItemProduto.Next;
        end;

        qry.ExecSQL;
        DM.DBConnection.Commit;

        Result := CodigoPedido;

      except
          DM.DBConnection.Rollback;
          Result := 0;
      end;

   finally
     FormatSettings.DecimalSeparator := ',';
     qry.Free;
   end;

end;


procedure TPedidoDeVendas.Button2Click(Sender: TObject);
begin
  tsCliente.Tag := qryCliente.FieldByName('codigo').AsInteger;
  Label3.Caption := qryCliente.FieldByName('nome').AsString;
  PageControl1.ActivePage := tsPedido;
end;

procedure TPedidoDeVendas.Button4Click(Sender: TObject);
begin
  PageControl1.ActivePage := tsFechamento;
end;

procedure TPedidoDeVendas.Button5Click(Sender: TObject);
begin
  PageControl1.ActivePage := tsCliente;
end;

procedure TPedidoDeVendas.edClienteEnter(Sender: TObject);
begin
  edCliente.Clear;
end;

// Parametros:
// 0 = query para codigo
// 1 = parametro da query codigo
// 2 = query para nome, descricao, etc
// 3 = parametro da query nome, descricao, etc
// 4 = informacao a ser pesquisada
// ** de novo, abordagem positiva: não estou verificando a quantidade
// de parametros
procedure TPedidoDeVendas.LocalizarEmQuery(const Query: TFDQuery;
  Parametros: TStringDynArray);
begin

  // well...
  Query.DisableControls;
  Query.Close;

  // Aqui eu verifico se o parametro é numerico,
  //
  if System.Char.IsNumber(Parametros[P_DIGITADO], 0) then
  begin
    Query.SQL.Text := Parametros[P_QUERY_CODIGO];
    Query.ParamByName(Parametros[P_PARAM_CODIGO]).AsString :=
      Parametros[P_DIGITADO] + '%';
  end
  else
  begin
    Query.SQL.Text := Parametros[P_QUERY_NOME];
    Query.ParamByName(Parametros[P_PARAM_NOME]).AsString :=
      Parametros[P_DIGITADO] + '%';
  end;

  Query.Open;
  Query.EnableControls;

end;

procedure TPedidoDeVendas.mtItemProdutoQuantidadeChange(Sender: TField);
begin
   mtItemProdutoTotal.AsFloat := mtItemProdutoPreco.AsFloat * mtItemProdutoQuantidade.AsFloat;
   TotalPedido := TotalPedido + mtItemProdutoTotal.AsFloat;
   MostraTotal();
end;

procedure TPedidoDeVendas.edClienteChange(Sender: TObject);
begin
  if String(edCliente.Text).IsEmpty then
    Exit;

  LocalizarEmQuery(qryCliente, [QueryContainer['localiza_cliente_codigo'],
    'codigo', QueryContainer['localiza_cliente_nome'], 'nome', edCliente.Text]);

end;

procedure TPedidoDeVendas.edProdutoChange(Sender: TObject);
begin
  if String(edProduto.Text).IsEmpty then
    Exit;

  LocalizarEmQuery(qryProduto, [QueryContainer['localiza_produto_codigo'],
    'codigo', QueryContainer['localiza_produto_descricao'], 'descricao',
    edProduto.Text]);
  TFloatField(qryProduto.FieldByName('preco')).DisplayFormat := '0.00';
end;

procedure TPedidoDeVendas.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := tsCliente;
end;

procedure TPedidoDeVendas.FormDestroy(Sender: TObject);
begin

  if Assigned(QueryContainer) then
    QueryContainer.Free;

  if Assigned(qryCliente) then
    qryCliente.Free;

  if Assigned(qryProduto) then
    qryProduto.Free;

end;

procedure TPedidoDeVendas.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if PageControl1.ActivePage = tsCliente then
    AllowChange := tsCliente.Tag <> 0;

  if PageControl1.ActivePage = tsPedido then
    AllowChange := tsPedido.Tag <> 0;

end;

end.
