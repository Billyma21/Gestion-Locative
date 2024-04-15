unit unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql56conn, sqldb, db, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, DBCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
  Button1: TButton;
  Button2: TButton;
  Button3: TButton;
  ComboBox1: TComboBox;
  DataSource1: TDataSource;
  DataSource2: TDataSource;
  DBGrid1: TDBGrid;
  DBNavigator1: TDBNavigator;
  Edit1: TEdit;
  Edit10: TEdit;
  Edit11: TEdit;
  Edit2: TEdit;
  Edit3: TEdit;
  Edit4: TEdit;
  Edit5: TEdit;
  Edit6: TEdit;
  Edit7: TEdit;
  Edit8: TEdit;
  Edit9: TEdit;
  Label1: TLabel;
  Label2: TLabel;
  Label3: TLabel;
  Label4: TLabel;
  Label5: TLabel;
  Label6: TLabel;
  Label8: TLabel;
  MySQL56Connection1: TMySQL56Connection;
  Splitter2: TSplitter;
  SQLQuery1: TSQLQuery;
  SQLQuery2: TSQLQuery;
  SQLQuery3: TSQLQuery;
  SQLQuery4: TSQLQuery;
  SQLTransaction1: TSQLTransaction;
procedure Button1Click(Sender: TObject);
procedure Button2Click(Sender: TObject);
procedure Button3Click(Sender: TObject);
procedure ComboBox1Change(Sender: TObject);
procedure DataSource1DataChange(Sender: TObject; Field: TField);
procedure DBComboBox1Change(Sender: TObject);
procedure DBLookupComboBox1Change(Sender: TObject);
procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
procedure Edit10Change(Sender: TObject);
procedure Edit12Change(Sender: TObject);
procedure Edit1Change(Sender: TObject);
procedure FormCreate(Sender: TObject);
procedure Label1Click(Sender: TObject);
procedure Label2Click(Sender: TObject);
procedure Label3Click(Sender: TObject);
procedure Label4Click(Sender: TObject);
procedure Label8Click(Sender: TObject);
procedure MySQL56Connection1AfterConnect(Sender: TObject);
procedure Splitter1CanOffset(Sender: TObject; var NewOffset: Integer;
  var Accept: Boolean);
private

public

end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  MySQL56Connection1.DatabaseName:='locationbien';
  MySQL56Connection1.UserName:='root';
  MySQL56Connection1.Open;
  if Not MySQL56Connection1.Connected then
  begin
    ShowMessage ('retenté la connexion à echouer'); exit;
  end;
  Button1.Visible:= false;
  Label8.Visible:=false;
  SQLQuery1.SQL.Text:= 'SELECT * FROM bien';
  SQLQuery1.Open;
  SQLQuery2.SQL.Text := 'SELECT DISTINCT lieu FROM bien';
  SQLQuery2.Open;
  SQLQuery2.First;
  while(not SQLQuery2.EOF) do
  begin
    ComboBox1.Items.Add(SQLQuery2.Fields.Fields[0].AsString);
    SQLQuery2.Next;
  end;
  SQLQuery2.Close;
  SQLQuery3.SQL.Text := 'SELECT sum(prix) AS prix_total FROM bien';
  SQLQuery3.Open;
  SQLQuery3.First;
  Edit9.Text := SQLQuery3.Fields.Fields[0].AsString;
  SQLQuery3.Close;
  Datasource1.Dataset:=SQLQuery1;
  DBGrid1.DataSource:=DataSource1;
  SQLQuery1.Open;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Text := DBGrid1.Columns[0].Field.Text;
  Edit2.Text := DBGrid1.Columns[2].Field.Text;
  Edit3.Text := DBGrid1.Columns[3].Field.Text;
  Edit4.Text := DBGrid1.Columns[4].Field.Text;
  Edit5.Text := DBGrid1.Columns[5].Field.Text;
end;

procedure TForm1.Button3Click(Sender: TObject);
var Prix, newprice: double;
var numerobien, PrixStr, prix_change: string;
begin
  if (Edit6.Text ='') then
  ShowMessage ( 'il est nécessaire introduire un numero de bien' )
  else
  if(Edit7.Text ='') and (Edit8.Text <='')then
  ShowMessage ( 'insere un pourcentage pour recalculer le prix svp' )
  else
  begin
    numerobien := QuotedStr(Edit6.Text);
    SQLQuery4.Close;
    SQLQuery4.SQL.Text := 'SELECT prix FROM bien WHERE bien_id ='+numerobien;
    SQLQuery4.Open;
    Edit10.Text := SQLQuery4.Fields.Fields[0].AsString;
    SQLQuery4.Close;

    if (Edit7.Text <>'') and (Edit8.Text <>'') then
    ShowMessage ( 'il faut utiliser un des champs' )
    else
    begin
      if (Edit7.Text <>'') then
      begin
        Prix := 1.0 + (StrToFloat(Edit7.Text)/100);
        str(Prix:10:2,PrixStr);

      end;
      if (Edit8.Text <>'') then
      begin
        Prix := 1.0 - (StrToFloat(Edit8.Text)/100);
        str(Prix:10:2,PrixStr);

      end;
      newprice :=(StrToFloat(Edit10.Text) * Prix);
      str(newprice:10:2,prix_change);
      Edit11.Text := prix_change;


	  SQLTransaction1.commit;
	  SQlTransaction1.StartTransaction;
	  MySQL56Connection1.ExecuteDirect('set@p0='+numerobien );
	  MySQL56Connection1.ExecuteDirect('set@p1='+prix_change);
	  MySQL56Connection1.ExecuteDirect('call  procedure_prix(@p0,@p1)');
	  SQLTransaction1.Commit;
      SQLQuery1.Close;
      SQLQuery1.SQL.Text:= 'SELECT * FROM bien';
      SQLQuery1.Open;
    end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  SQLQuery1.Close;
  if(Combobox1.Text='Tous') then
    SQLQuery1.SQL.Text:= 'SELECT * FROM bien'
  else
   SQLQuery1.SQL.Text:= 'SELECT * FROM bien WHERE lieu="'+ComboBox1.Text+'"';
  SQLQuery1.Open;
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin

end;

procedure TForm1.DBComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.DBLookupComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
begin

end;

procedure TForm1.Edit10Change(Sender: TObject);
begin

end;

procedure TForm1.Edit12Change(Sender: TObject);
begin

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Label3Click(Sender: TObject);
begin

end;

procedure TForm1.Label4Click(Sender: TObject);
begin

end;



procedure TForm1.Label8Click(Sender: TObject);
begin

end;



procedure TForm1.MySQL56Connection1AfterConnect(Sender: TObject);
begin

end;

procedure TForm1.Splitter1CanOffset(Sender: TObject; var NewOffset: Integer;
  var Accept: Boolean);
begin

end;

end.

