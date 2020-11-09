object PedidoDeVendas: TPedidoDeVendas
  Left = 0
  Top = 0
  Caption = 'Pedido de Vendas - LIVROS INFANTIS'
  ClientHeight = 555
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 758
    Height = 57
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 3
    ExplicitWidth = 849
    object btIncluir: TButton
      Left = 8
      Top = 17
      Width = 110
      Height = 25
      Caption = '+ Novo Pedido'
      TabOrder = 0
      OnClick = btIncluirClick
    end
    object btCancelar: TButton
      Left = 139
      Top = 17
      Width = 110
      Height = 25
      Caption = 'x Cancelar'
      Enabled = False
      TabOrder = 1
      OnClick = btCancelarClick
    end
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 73
    Width = 758
    Height = 474
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tsCliente
    Align = alClient
    MultiLine = True
    TabOrder = 1
    OnChanging = PageControl1Changing
    ExplicitTop = 81
    ExplicitHeight = 466
    object tsCliente: TTabSheet
      Caption = 'Cliente'
      ExplicitLeft = 8
      ExplicitHeight = 438
      object Label1: TLabel
        Left = 8
        Top = 11
        Width = 76
        Height = 13
        Caption = 'Nome/C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 90
        Top = 11
        Width = 265
        Height = 13
        Caption = '(digite o nome, c'#243'digo do cliente ou % para ver todos) '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object edCliente: TEdit
        Left = 9
        Top = 30
        Width = 728
        Height = 21
        TabOrder = 0
        OnChange = edClienteChange
        OnEnter = edClienteEnter
      end
      object dgCliente: TDBGrid
        Left = 9
        Top = 57
        Width = 728
        Height = 331
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Codigo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Cidade'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Estado'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UF'
            Width = 60
            Visible = True
          end>
      end
      object Button2: TButton
        Left = 624
        Top = 394
        Width = 113
        Height = 25
        Caption = 'SELECIONAR >>'
        TabOrder = 2
        OnClick = Button2Click
      end
    end
    object tsPedido: TTabSheet
      Caption = 'Pedido'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 40
      ExplicitHeight = 438
      object Label3: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 744
        Height = 14
        Align = alTop
        Caption = 'Cliente'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 15
        ExplicitTop = 16
        ExplicitWidth = 42
      end
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 8
        Top = 24
        Width = 734
        Height = 185
        Margins.Left = 8
        Margins.Top = 4
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alTop
        Caption = ' PRODUTO '
        TabOrder = 0
        object Label4: TLabel
          Left = 16
          Top = 16
          Width = 76
          Height = 13
          Caption = 'Nome/C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 98
          Top = 16
          Width = 250
          Height = 13
          Caption = '(digite o nome, c'#243'digo do produto ou % para todos)'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object edProduto: TEdit
          Left = 16
          Top = 35
          Width = 706
          Height = 21
          TabOrder = 0
          OnChange = edProdutoChange
          OnEnter = edClienteEnter
        end
        object btIncluirProduto: TButton
          Left = 16
          Top = 151
          Width = 113
          Height = 25
          Caption = '+ Incluir'
          TabOrder = 1
          OnClick = btIncluirProdutoClick
        end
        object gbProduto: TDBGrid
          Left = 16
          Top = 62
          Width = 705
          Height = 83
          DataSource = DataSource2
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'Codigo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              Title.Caption = 'Descri'#231#227'o'
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Preco'
              Title.Caption = 'Pre'#231'o'
              Visible = True
            end>
        end
      end
      object GroupBox3: TGroupBox
        AlignWithMargins = True
        Left = 8
        Top = 220
        Width = 734
        Height = 184
        Margins.Left = 8
        Margins.Right = 8
        Align = alTop
        Caption = ' ITENS DO PEDIDO '
        TabOrder = 1
        object lbTotal: TLabel
          Left = 141
          Top = 151
          Width = 134
          Height = 14
          Caption = 'Total Pedido: R$ 0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Button3: TButton
          Left = 16
          Top = 146
          Width = 113
          Height = 25
          Caption = '- Remover'
          TabOrder = 0
        end
        object dgItem: TDBGrid
          Left = 16
          Top = 17
          Width = 705
          Height = 123
          DataSource = DataSource3
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnKeyUp = dgItemKeyUp
          Columns = <
            item
              Expanded = False
              FieldName = 'Codigo'
              ReadOnly = True
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              ReadOnly = True
              Title.Caption = 'Descri'#231#227'o'
              Width = 357
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Quantidade'
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Preco'
              Title.Caption = 'Pre'#231'o'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Total'
              ReadOnly = True
              Width = 80
              Visible = True
            end>
        end
      end
      object Button4: TButton
        Left = 617
        Top = 410
        Width = 113
        Height = 25
        Caption = 'CONCLUIR >>'
        TabOrder = 2
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 24
        Top = 410
        Width = 113
        Height = 25
        Caption = '<< RETORNAR'
        TabOrder = 3
        OnClick = Button5Click
      end
    end
    object tsFechamento: TTabSheet
      Caption = 'Fechamento'
      ImageIndex = 2
      ExplicitLeft = 8
      ExplicitHeight = 438
      object Label6: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 744
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 'RESUMO DO PEDIDO'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ExplicitWidth = 125
      end
      object GroupBox4: TGroupBox
        AlignWithMargins = True
        Left = 8
        Top = 23
        Width = 734
        Height = 368
        Margins.Left = 8
        Margins.Right = 8
        Align = alTop
        Caption = ' ITENS DO PEDIDO '
        TabOrder = 0
        object lbTotalFinal: TLabel
          Left = 16
          Top = 338
          Width = 134
          Height = 14
          Caption = 'Total Pedido: R$ 0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DBGrid1: TDBGrid
          Left = 16
          Top = 17
          Width = 705
          Height = 315
          DataSource = DataSource3
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnKeyUp = dgItemKeyUp
          Columns = <
            item
              Expanded = False
              FieldName = 'Codigo'
              ReadOnly = True
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              ReadOnly = True
              Title.Caption = 'Descri'#231#227'o'
              Width = 357
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Quantidade'
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Preco'
              Title.Caption = 'Pre'#231'o'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Total'
              ReadOnly = True
              Width = 80
              Visible = True
            end>
        end
      end
      object btFecharPedido: TButton
        Left = 313
        Top = 397
        Width = 113
        Height = 25
        Caption = #8730' FECHAR PEDIDO'
        TabOrder = 1
        OnClick = btFecharPedidoClick
      end
    end
  end
  object DataSource1: TDataSource
    Left = 448
    Top = 25
  end
  object DataSource2: TDataSource
    Left = 504
    Top = 25
  end
  object DataSource3: TDataSource
    DataSet = mtItemProduto
    Left = 576
    Top = 25
  end
  object mtItemProduto: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 632
    Top = 24
    object mtItemProdutoCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object mtItemProdutoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 80
    end
    object mtItemProdutoPreco: TFloatField
      FieldName = 'Preco'
      OnChange = mtItemProdutoQuantidadeChange
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object mtItemProdutoQuantidade: TIntegerField
      FieldName = 'Quantidade'
      OnChange = mtItemProdutoQuantidadeChange
    end
    object mtItemProdutoTotal: TFloatField
      FieldName = 'Total'
      DisplayFormat = '#,##0.00'
      currency = True
    end
  end
end
