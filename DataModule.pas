unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.FMTBcd, Data.DB, Data.SqlExpr,
  FireDAC.Comp.Client, System.Generics.Collections;

const
  CONFIG_DB = '.\db.conf';

type
  TDM = class(TDataModule)
    DBConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function OpenDatabase: Boolean;

var
  DM: TDM;
  QueryContainer: TDictionary<String, String>;

procedure carregarQueryContainer;
procedure iniciaContainer(QueryContainer: TDictionary<String, String>);
procedure criarQuery(var Query: TFDQuery; SQL: String;
  DataSource: TDataSource = nil);

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure carregarQueryContainer;
begin
  QueryContainer := TDictionary<String, String>.Create;
  iniciaContainer(QueryContainer);
end;

function OpenDatabase: Boolean;
begin
  Result := False;

  if FileExists(CONFIG_DB) then
  begin
    DM.DBConnection.Params.LoadFromFile(CONFIG_DB);
    DM.DBConnection.Open();
    Result := True;
  end;

end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  carregarQueryContainer();
end;

procedure iniciaContainer(QueryContainer: TDictionary<String, String>);
var
  FiltroOperacao, qry: String;
begin
  // No mundo real estas queries devem estar no banco, preferencialmente, e formatadas :)
  // Cliente
  qry := 'select cl.Codigo, cl.Nome, cl.Cidade, ci.Estado, ci.UF from cliente cl ' +
         'inner join cidade ci on ci.Codigo = cl.UF ';
  QueryContainer.Add('localiza_cliente_nome', qry + 'where cl.Nome like :nome;');
  QueryContainer.Add('localiza_cliente_codigo', qry + 'where cl.Codigo=:codigo;');

  // Produto
  qry := 'select Codigo, Descricao, Preco from produto ';
  QueryContainer.Add('localiza_produto_codigo', qry + 'where Codigo=:codigo;');
  QueryContainer.Add('localiza_produto_descricao', qry + 'where Descricao like :descricao;');

end;

procedure criarQuery(var Query: TFDQuery; SQL: String;
  DataSource: TDataSource = nil);
begin

  Query := TFDQuery.Create(nil);

  try
    Query.Connection := DM.DBConnection;

    if not SQL.IsEmpty then
      Query.SQL.Text := QueryContainer[SQL];

    if Assigned(DataSource) then
      DataSource.DataSet := Query;
  except
    // Se isto acontecer, não devemos no mundo real
    // simplesmente liberar, pois é obrigatório um
    // tratamento mais adequado.
    // Porém, neste teste estou considerando a abordagem positiva
    Query.Free;
  end;

end;

end.
