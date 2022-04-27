pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenRecords;

package KartengeneratorRessourcen is

   procedure AufteilungRessourcengenerierung;

private
   
   type WahrscheinlichkeitRessourceArray is array (KartenDatentypen.Kartenressourcen_Enum'Range, KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum'Range) of Float;
   WahrscheinlichkeitRessourcen : constant WahrscheinlichkeitRessourceArray := (
                                                                                KartenDatentypen.Kartenressourcen_Arm_Enum =>
                                                                                  (
                                                                                   KartengrundDatentypen.Fisch_Enum              => 0.02,
                                                                                   KartengrundDatentypen.Wal_Enum                => 0.00,
                                                                                   KartengrundDatentypen.Kohle_Enum              => 0.02,
                                                                                   KartengrundDatentypen.Eisen_Enum              => 0.02,
                                                                                   KartengrundDatentypen.Öl_Enum                 => 0.02,
                                                                                   KartengrundDatentypen.Hochwertiger_Boden_Enum => 0.02,
                                                                                   KartengrundDatentypen.Gold_Enum               => 0.00
                                                                                  ),
                                                                                
                                                                                KartenDatentypen.Kartenressourcen_Wenig_Enum =>
                                                                                  (
                                                                                   KartengrundDatentypen.Fisch_Enum              => 0.04,
                                                                                   KartengrundDatentypen.Wal_Enum                => 0.01,
                                                                                   KartengrundDatentypen.Kohle_Enum              => 0.04,
                                                                                   KartengrundDatentypen.Eisen_Enum              => 0.04,
                                                                                   KartengrundDatentypen.Öl_Enum                 => 0.04,
                                                                                   KartengrundDatentypen.Hochwertiger_Boden_Enum => 0.04,
                                                                                   KartengrundDatentypen.Gold_Enum               => 0.01
                                                                                  ),
                                                                                
                                                                                KartenDatentypen.Kartenressourcen_Mittel_Enum =>
                                                                                  (
                                                                                   KartengrundDatentypen.Fisch_Enum              => 0.08,
                                                                                   KartengrundDatentypen.Wal_Enum                => 0.02,
                                                                                   KartengrundDatentypen.Kohle_Enum              => 0.08,
                                                                                   KartengrundDatentypen.Eisen_Enum              => 0.08,
                                                                                   KartengrundDatentypen.Öl_Enum                 => 0.08,
                                                                                   KartengrundDatentypen.Hochwertiger_Boden_Enum => 0.08,
                                                                                   KartengrundDatentypen.Gold_Enum               => 0.02
                                                                                  ),
                                                                                
                                                                                KartenDatentypen.Kartenressourcen_Viel_Enum =>
                                                                                  (
                                                                                   KartengrundDatentypen.Fisch_Enum              => 0.16,
                                                                                   KartengrundDatentypen.Wal_Enum                => 0.04,
                                                                                   KartengrundDatentypen.Kohle_Enum              => 0.16,
                                                                                   KartengrundDatentypen.Eisen_Enum              => 0.16,
                                                                                   KartengrundDatentypen.Öl_Enum                 => 0.16,
                                                                                   KartengrundDatentypen.Hochwertiger_Boden_Enum => 0.16,
                                                                                   KartengrundDatentypen.Gold_Enum               => 0.04
                                                                                  ),
                                                                                
                                                                                KartenDatentypen.Kartenressourcen_Überfluss_Enum =>
                                                                                  (
                                                                                   KartengrundDatentypen.Fisch_Enum              => 0.32,
                                                                                   KartengrundDatentypen.Wal_Enum                => 0.08,
                                                                                   KartengrundDatentypen.Kohle_Enum              => 0.32,
                                                                                   KartengrundDatentypen.Eisen_Enum              => 0.32,
                                                                                   KartengrundDatentypen.Öl_Enum                 => 0.32,
                                                                                   KartengrundDatentypen.Hochwertiger_Boden_Enum => 0.32,
                                                                                   KartengrundDatentypen.Gold_Enum               => 0.08
                                                                                  )
                                                                               );
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure GenerierungRessourcen;
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure RessourcenWasser
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenLand
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenUmgebungBelegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

end KartengeneratorRessourcen;
