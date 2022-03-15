pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;
with EinheitenKonstanten;
with KartenVerbesserungKonstanten;
with TastenbelegungKonstanten;

with SchreibeEinheitenGebaut;

package body AufgabenAllgemein is

   function Beschreibung
     (KartenVerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
      return Wide_Wide_String
   is begin
      
      case
        KartenVerbesserungExtern
      is
         when KartenVerbesserungKonstanten.LeerVerbesserung =>
            BeschreibungText := SystemKonstanten.LeerUnboundedString;
            
         when others =>
            AktuelleVerbesserung := 2 * KartenVerbesserungDatentypen.Karten_Verbesserung_Enum'Pos (KartenVerbesserungExtern) - 1;
               
            BeschreibungText := GlobaleTexte.Verbesserungen (AktuelleVerbesserung);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end Beschreibung;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => TastenbelegungKonstanten.LeerTastenbelegungKonstante);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => EinheitenKonstanten.LeerEinheit.Beschäftigungszeit,
                                                   RechnenSetzenExtern      => 0);
      SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        BeschäftigungExtern     => TastenbelegungKonstanten.LeerTastenbelegungKonstante);
      SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             ZeitExtern               => EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger,
                                                             RechnenSetzenExtern      => 0);
      
   end Nullsetzung;

end AufgabenAllgemein;
