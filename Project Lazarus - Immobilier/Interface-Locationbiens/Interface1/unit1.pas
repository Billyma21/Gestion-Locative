unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, sqldb, mysql56conn, odbcconn, Forms,
  Controls, Graphics, Dialogs, Grids, DBGrids, StdCtrls, DBCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnAjouter: TButton;
    btnSupprimer: TButton;
    btnRecherche: TButton;
    btnConnection: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    edtId: TEdit;
    edtSuperficie: TEdit;
    edtNom: TEdit;
    edtPrenom: TEdit;
    edtDomicile: TEdit;
    edtDDN: TEdit;
    edtNom2: TEdit;
    edtDomicile2: TEdit;
    edtCommune: TEdit;
    edtPrix: TEdit;
    lblId: TLabel;
    lblSuperficie: TLabel;
    lblCon: TLabel;
    lblNom: TLabel;
    lblPrenom: TLabel;
    lblDomicile: TLabel;
    lblDDN: TLabel;
    lblNom2: TLabel;
    lblDomicile2: TLabel;
    lblCommune: TLabel;
    lblPrix: TLabel;
    MySQL56Connection1: TMySQL56Connection;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure btnAjouterClick(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure btnRechercheClick(Sender: TObject);
    procedure btnSupprimerClick(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure lblConClick(Sender: TObject);
    procedure SQLQuery1AfterRefresh();
    procedure SQLQuery1AfterPost(DataSet: TDataSet);
    procedure SQLQuery1AfterDelete(DataSet: TDataSet);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnConnectionClick(Sender: TObject);
begin
  MySQL56Connection1.Open;
  if Not MySQL56Connection1.Connected then
    begin
     ShowMessage ('la connexion est pas etabli'); exit;
    end;
  lblCon.Caption:='CONNECTE';
   SQLQuery1.SQL.Text:= 'SELECT * FROM proprio WHERE actif="1"';
   SQLQuery1.Open;
   SQLQuery2.SQL.Text:='SELECT nom,domicile,lieu,prix,superficie FROM proprio,bien WHERE proprio_id=id_proprio';
   SQLQuery2.Open;
end;

procedure TForm1.btnRechercheClick(Sender: TObject);
  var rechNom,rechDomicile,rechLieu,rechPrix,rechSuperficie:string;
begin
   if edtNom2.text='' then
     rechNom:='true'
   else
     rechNom:='nom='+QuotedStr(edtNom2.text);

   if edtDomicile2.text='' then
     rechDomicile:='true'
   else
     rechDomicile:='domicile='+QuotedStr(edtDomicile2.text);

   if edtCommune.text='' then
     rechLieu:='true'
   else
     rechLieu:='lieu='+QuotedStr(edtCommune.text);

   if edtPrix.text='' then
     rechPrix:='true'
   else
     rechPrix:='prix='+QuotedStr(edtPrix.text);

   if edtSuperficie.text='' then
     rechSuperficie:='true'
   else
     rechSuperficie:='superficie='+QuotedStr(edtSuperficie.text);

   SQLQuery2.Close;
   SQLQuery2.SQL.Text := 'SELECT nom,domicile,lieu,prix,superficie FROM proprio,bien WHERE proprio_id=id_proprio'
              + ' and ' + rechNom + ' and ' + rechDomicile +' and '+ rechLieu + ' and ' + rechPrix + ' and ' + rechSuperficie ;
   SQLQuery2.Open;
end;

procedure TForm1.btnSupprimerClick(Sender: TObject);
begin
  SQLTransaction1.Commit;
  SQLTransaction1.StartTransaction;

  MySQL56Connection1.ExecuteDirect('update proprio set actif="0" where proprio_id = '  +edtId.text);
  SQLTransaction1.commit;
  SQLQuery1.SQL.Text:= 'SELECT * FROM proprio WHERE actif="1"';
  SQLQuery1.Open;
  SQLQuery2.SQL.Text:= 'SELECT nom,domicile,lieu,prix,superficie FROM proprio,bien WHERE proprio_id=id_proprio';
  SQLQuery2.Open;
end;

procedure TForm1.DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
begin

end;

procedure TForm1.lblConClick(Sender: TObject);
begin

end;

procedure TForm1.btnAjouterClick(Sender: TObject);
  var proprio_id,nom,prenom,domicile,annee_naissance:string;
begin
  proprio_id := QuotedStr(edtId.text);
  nom := QuotedStr(edtNom.text);
  prenom := QuotedStr(edtPrenom.text);
  domicile := QuotedStr(edtDomicile.text);
  annee_naissance := edtDDN.text;
  SQLTransaction1.commit;
  SQLTransaction1.StartTransaction;
  MySQL56Connection1.ExecuteDirect('INSERT INTO proprio(nom,prenom,domicile,annee_naissance) Values ('+nom+','+prenom+','+domicile+','+annee_naissance+')');


  SQLTransaction1.commit;
  SQLQuery1.SQL.Text:= 'SELECT * FROM proprio WHERE actif="1"';
  SQLQuery1.Open;
  SQLQuery2.SQL.Text:='SELECT nom,domicile,lieu,prix,superficie FROM proprio,bien WHERE proprio_id = id_proprio';
  SQLQuery2.Open;
end;

procedure TForm1.SQLQuery1AfterRefresh();
begin
   SQLQuery1.SQL.Text:= 'SELECT * FROM proprio';
  SQLQuery1.Open;
  SQLQuery2.SQL.Text:= 'SELECT nom,domicile,lieu,prix,superficie FROM proprio,bien WHERE proprio_id=id_proprio';
  SQLQuery2.Open;
end;

procedure TForm1.SQLQuery1AfterPost(DataSet: TDataSet);
begin
  SQLQuery1.ApplyUpdates();
  SQLTransaction1.commit;
  SQLQuery1AfterRefresh();
end;

procedure TForm1.SQLQuery1AfterDelete(DataSet: TDataSet);
begin
  SQLQuery1.ApplyUpdates();
  SQLTransaction1.commit;
  SQLQuery1AfterRefresh();
end;
end.

