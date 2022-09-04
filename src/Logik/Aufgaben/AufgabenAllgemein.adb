pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Kartentexte;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;

package body AufgabenAllgemein is

   function BeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      AktuelleVerbesserung := 2 * KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Pos (KartenVerbesserungExtern) - 1;
               
      BeschreibungText := Kartentexte.Verbesserungen (AktuelleVerbesserung);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungVerbesserung;
   
   

   function BeschreibungWeg
     (KartenWegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      AktuellerWeg := 2 * KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (KartenWegExtern) - 1;
               
      BeschreibungText := Kartentexte.Wege (AktuellerWeg);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungWeg;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => EinheitenKonstanten.LeerBeschäftigungszeit,
                                                   RechnenSetzenExtern      => 0);
      SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
      SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             ZeitExtern               => EinheitenKonstanten.LeerBeschäftigungszeit,
                                                             RechnenSetzenExtern      => 0);
      
   end Nullsetzung;

end AufgabenAllgemein;
