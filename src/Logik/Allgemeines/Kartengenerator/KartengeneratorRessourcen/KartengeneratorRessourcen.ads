pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenRecords;

package KartengeneratorRessourcen is

   procedure AufteilungRessourcengenerierung;

private
   
   type WahrscheinlichkeitRessourceArray is array (KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum'Range) of Float;
   WahrscheinlichkeitRessourcen : constant WahrscheinlichkeitRessourceArray := (
                                                                                KartengrundDatentypen.Fisch_Enum              => 0.02,
                                                                                KartengrundDatentypen.Wal_Enum                => 0.00,
                                                                                KartengrundDatentypen.Kohle_Enum              => 0.02,
                                                                                KartengrundDatentypen.Eisen_Enum              => 0.02,
                                                                                KartengrundDatentypen.Öl_Enum                 => 0.02,
                                                                                KartengrundDatentypen.Hochwertiger_Boden_Enum => 0.02,
                                                                                KartengrundDatentypen.Gold_Enum               => 0.00
                                                                               );
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure GenerierungRessourcen;
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);

end KartengeneratorRessourcen;
