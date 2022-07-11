pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body UmwandlungenGleicheDatentypen is

   function KartenfeldNaturalNachKartenfeldVorhanden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldVorhandenRecord
   is begin
      
      return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
      
   end KartenfeldNaturalNachKartenfeldVorhanden;
   
   
   
   --------------------------------- Darüber noch einmal nachdenken, die Idee scheint gut, die Umsetzung ist etwas kompliziert.
   -- function TastenbelegungNachAufgaben
  --   (BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
   --   return AufgabenDatentypen.Einheiten_Aufgabe_Vorhanden_Enum
  -- is begin

end UmwandlungenGleicheDatentypen;
