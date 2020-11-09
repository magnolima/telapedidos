object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 235
  Width = 345
  object DBConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Database=teste_schema'
      'Password=syspwd'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Left = 40
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = '.\libmysql.dll'
    Left = 128
    Top = 24
  end
end
