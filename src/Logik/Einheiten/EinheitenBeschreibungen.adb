pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleTexte;
with SystemKonstanten;
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
            Fehler.GrafikStopp (FehlermeldungExtern => "EinheitenBeschreibungen.BeschreibungKurz - Einheit sollte existieren tut sie aber nicht.");
            
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
            Fehler.GrafikStopp (FehlermeldungExtern => "EinheitenBeschreibungen.BeschreibungLang - Einheit sollte existieren tut sie aber nicht.");
            
         when others =>
            Textnummer := 2 * Positive (IDExtern);
               
            BeschreibungText := GlobaleTexte.Einheiten (Textnummer);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungLang;
   
   
   
   function Beschäftigung
     (ArbeitExtern : in SystemDatentypen.Tastenbelegung_Enum)
      return Wide_Wide_String
   is begin
      
      case
        ArbeitExtern
      is
         when SystemDatentypen.Leer =>
            BeschäftigungText := GlobaleTexte.Beschäftigungen (17);
               
         when SystemDatentypen.Tastenbelegung_Befehle_Anzeige'Range =>
            if
              ArbeitExtern = SystemDatentypen.Straße_Bauen
            then
               BeschäftigungText := GlobaleTexte.Beschäftigungen (1);
                  
            else
               BeschäftigungText := GlobaleTexte.Beschäftigungen (2 * (SystemDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - EinheitenKonstanten.EinheitBefehlAbzug) - 1);
            end if;
               
         when others =>
            Fehler.GrafikStopp (FehlermeldungExtern => "EinheitenBeschreibungen.Beschäftigung - Führt keine gültige Aufgabe durch.");
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
         when SystemKonstanten.JaKonstante =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenBeschreibungen;
