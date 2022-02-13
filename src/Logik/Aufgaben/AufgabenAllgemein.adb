pragma SPARK_Mode (On);

with GlobaleTexte;
with EinheitenKonstanten;
with KartenKonstanten;

with SchreibeEinheitenGebaut;

package body AufgabenAllgemein is

   function Beschreibung
     (KartenVerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return Wide_Wide_String
   is begin
      
      case
        KartenVerbesserungExtern
      is
         when KartenKonstanten.LeerVerbesserung =>
            BeschreibungText := SystemKonstanten.LeerUnboundedString;
            
         when others =>
            AktuelleVerbesserung := 2 * KartenDatentypen.Karten_Verbesserung_Enum'Pos (KartenVerbesserungExtern) - 1;
               
            BeschreibungText := GlobaleTexte.Verbesserungen (AktuelleVerbesserung);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end Beschreibung;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => SystemKonstanten.LeerTastenbelegungKonstante);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => EinheitenKonstanten.LeerEinheit.Beschäftigungszeit,
                                                   RechnenSetzenExtern      => 0);
      SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        BeschäftigungExtern     => SystemKonstanten.LeerTastenbelegungKonstante);
      SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             ZeitExtern               => EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger,
                                                             RechnenSetzenExtern      => 0);
      
   end Nullsetzung;

end AufgabenAllgemein;
