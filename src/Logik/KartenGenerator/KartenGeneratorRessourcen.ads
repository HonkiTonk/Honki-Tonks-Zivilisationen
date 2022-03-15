pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen;
with KartenRecords;
with KartenEinstellungenKonstanten;

package KartenGeneratorRessourcen is

   procedure GenerierungRessourcen;

private
   
   type WahrscheinlichkeitRessourceArray is array (KartenDatentypen.Kartenressourcen_Verwendet_Enum'Range, KartenGrundDatentypen.Karten_Grund_Ressourcen_Enum'Range) of Float;
   WahrscheinlichkeitRessourcen : constant WahrscheinlichkeitRessourceArray := (
                                                                                KartenEinstellungenKonstanten.RessourcenArmKonstante =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch              => 0.02,
                                                                                   KartenGrundDatentypen.Wal                => 0.00,
                                                                                   KartenGrundDatentypen.Kohle              => 0.02,
                                                                                   KartenGrundDatentypen.Eisen              => 0.02,
                                                                                   KartenGrundDatentypen.Öl                 => 0.02,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden => 0.02,
                                                                                   KartenGrundDatentypen.Gold               => 0.00
                                                                                  ),
                                                                                
                                                                                KartenEinstellungenKonstanten.RessourcenWenigKonstante =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch              => 0.04,
                                                                                   KartenGrundDatentypen.Wal                => 0.01,
                                                                                   KartenGrundDatentypen.Kohle              => 0.04,
                                                                                   KartenGrundDatentypen.Eisen              => 0.04,
                                                                                   KartenGrundDatentypen.Öl                 => 0.04,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden => 0.04,
                                                                                   KartenGrundDatentypen.Gold               => 0.01
                                                                                  ),
                                                                                
                                                                                KartenEinstellungenKonstanten.RessourcenMittelKonstante =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch              => 0.08,
                                                                                   KartenGrundDatentypen.Wal                => 0.02,
                                                                                   KartenGrundDatentypen.Kohle              => 0.08,
                                                                                   KartenGrundDatentypen.Eisen              => 0.08,
                                                                                   KartenGrundDatentypen.Öl                 => 0.08,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden => 0.08,
                                                                                   KartenGrundDatentypen.Gold               => 0.02
                                                                                  ),
                                                                                
                                                                                KartenEinstellungenKonstanten.RessourcenVielKonstante =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch              => 0.16,
                                                                                   KartenGrundDatentypen.Wal                => 0.04,
                                                                                   KartenGrundDatentypen.Kohle              => 0.16,
                                                                                   KartenGrundDatentypen.Eisen              => 0.16,
                                                                                   KartenGrundDatentypen.Öl                 => 0.16,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden => 0.16,
                                                                                   KartenGrundDatentypen.Gold               => 0.04
                                                                                  ),
                                                                                
                                                                                KartenEinstellungenKonstanten.RessourcenÜberflussKonstante =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch              => 0.32,
                                                                                   KartenGrundDatentypen.Wal                => 0.08,
                                                                                   KartenGrundDatentypen.Kohle              => 0.32,
                                                                                   KartenGrundDatentypen.Eisen              => 0.32,
                                                                                   KartenGrundDatentypen.Öl                 => 0.32,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden => 0.32,
                                                                                   KartenGrundDatentypen.Gold               => 0.08
                                                                                  )
                                                                               );
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure RessourcenWasser
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenLand
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenUmgebungBelegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

end KartenGeneratorRessourcen;
