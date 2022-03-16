pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with SystemDatentypen;
with GlobaleTexte;
with EinheitenKonstanten;

with Auswahl;
with Fehler;

package body EinheitenBeschreibungen is

   function BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
            Fehler.GrafikFehler (FehlermeldungExtern => "EinheitenBeschreibungen.BeschreibungKurz - Einheit sollte existieren tut sie aber nicht.");
            
         when others =>
            Textnummer := 2 * Positive (IDExtern) - 1;
               
            BeschreibungText := GlobaleTexte.Einheiten (Textnummer);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
         
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
            Fehler.GrafikFehler (FehlermeldungExtern => "EinheitenBeschreibungen.BeschreibungLang - Einheit sollte existieren tut sie aber nicht.");
            
         when others =>
            Textnummer := 2 * Positive (IDExtern);
               
            BeschreibungText := GlobaleTexte.Einheiten (Textnummer);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungLang;
   
   
   
   function Beschäftigung
     (ArbeitExtern : in TastenbelegungDatentypen.Tastenbelegung_Enum)
      return Wide_Wide_String
   is begin
      
      case
        ArbeitExtern
      is
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum =>
            BeschäftigungText := GlobaleTexte.Beschäftigungen (17);
               
         when TastenbelegungDatentypen.Tastenbelegung_Befehle_Anzeige'Range =>
            if
              ArbeitExtern = TastenbelegungDatentypen.Straße_Bauen_Enum
            then
               BeschäftigungText := GlobaleTexte.Beschäftigungen (1);
                  
            else
               BeschäftigungText := GlobaleTexte.Beschäftigungen (2 * (TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - EinheitenKonstanten.EinheitBefehlAbzug) - 1);
            end if;
               
         when others =>
            Fehler.GrafikFehler (FehlermeldungExtern => "EinheitenBeschreibungen.Beschäftigung - Führt keine gültige Aufgabe durch.");
      end case;
         
      return To_Wide_Wide_String (Source => BeschäftigungText);
      
   end Beschäftigung;
   
      

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean
   is begin
         
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => WelcheAuswahlExtern)
      is
         when SystemDatentypen.Ja_Enum =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenBeschreibungen;
