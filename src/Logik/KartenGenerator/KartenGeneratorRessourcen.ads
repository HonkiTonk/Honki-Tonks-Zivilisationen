pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen;
with KartenGrundDatentypen;
with KartenRecords;

package KartenGeneratorRessourcen is

   procedure GenerierungRessourcen;

private
   
   type WahrscheinlichkeitRessourceArray is array (KartenDatentypen.Kartenressourcen_Verwendet_Enum'Range, KartenGrundDatentypen.Karten_Grund_Ressourcen_Enum'Range) of Float;
   WahrscheinlichkeitRessourcen : constant WahrscheinlichkeitRessourceArray := (
                                                                                SystemDatentypen.Karte_Ressource_Arm_Enum =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch_Enum              => 0.02,
                                                                                   KartenGrundDatentypen.Wal_Enum                => 0.00,
                                                                                   KartenGrundDatentypen.Kohle_Enum              => 0.02,
                                                                                   KartenGrundDatentypen.Eisen_Enum              => 0.02,
                                                                                   KartenGrundDatentypen.Öl_Enum                 => 0.02,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden_Enum => 0.02,
                                                                                   KartenGrundDatentypen.Gold_Enum               => 0.00
                                                                                  ),
                                                                                
                                                                                SystemDatentypen.Karte_Ressource_Wenig_Enum =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch_Enum              => 0.04,
                                                                                   KartenGrundDatentypen.Wal_Enum                => 0.01,
                                                                                   KartenGrundDatentypen.Kohle_Enum              => 0.04,
                                                                                   KartenGrundDatentypen.Eisen_Enum              => 0.04,
                                                                                   KartenGrundDatentypen.Öl_Enum                 => 0.04,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden_Enum => 0.04,
                                                                                   KartenGrundDatentypen.Gold_Enum               => 0.01
                                                                                  ),
                                                                                
                                                                                SystemDatentypen.Karte_Ressource_Mittel_Enum =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch_Enum              => 0.08,
                                                                                   KartenGrundDatentypen.Wal_Enum                => 0.02,
                                                                                   KartenGrundDatentypen.Kohle_Enum              => 0.08,
                                                                                   KartenGrundDatentypen.Eisen_Enum              => 0.08,
                                                                                   KartenGrundDatentypen.Öl_Enum                 => 0.08,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden_Enum => 0.08,
                                                                                   KartenGrundDatentypen.Gold_Enum               => 0.02
                                                                                  ),
                                                                                
                                                                                SystemDatentypen.Karte_Ressource_Viel_Enum =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch_Enum              => 0.16,
                                                                                   KartenGrundDatentypen.Wal_Enum                => 0.04,
                                                                                   KartenGrundDatentypen.Kohle_Enum              => 0.16,
                                                                                   KartenGrundDatentypen.Eisen_Enum              => 0.16,
                                                                                   KartenGrundDatentypen.Öl_Enum                 => 0.16,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden_Enum => 0.16,
                                                                                   KartenGrundDatentypen.Gold_Enum               => 0.04
                                                                                  ),
                                                                                
                                                                                SystemDatentypen.Karte_Ressource_Überfluss_Enum =>
                                                                                  (
                                                                                   KartenGrundDatentypen.Fisch_Enum              => 0.32,
                                                                                   KartenGrundDatentypen.Wal_Enum                => 0.08,
                                                                                   KartenGrundDatentypen.Kohle_Enum              => 0.32,
                                                                                   KartenGrundDatentypen.Eisen_Enum              => 0.32,
                                                                                   KartenGrundDatentypen.Öl_Enum                 => 0.32,
                                                                                   KartenGrundDatentypen.Hochwertiger_Boden_Enum => 0.32,
                                                                                   KartenGrundDatentypen.Gold_Enum               => 0.08
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
