pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleTexte;
with SystemKonstanten;
with EinheitenKonstanten;
with GlobaleVariablen;

with Anzeige;
with Auswahl;
with Fehler;

package body EinheitenBeschreibungen is

   function BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
      return Wide_Wide_String
   is begin
      
      if
        GlobaleVariablen.AnzeigeArt = SystemDatentypen.Konsole
      then
         case
           IDExtern
         is
            when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
               Fehler.LogikStopp (FehlermeldungExtern => "EinheitenBeschreibungen.BeschreibungKurz - Einheit sollte existieren tut sie aber nicht.");
            
            when others =>
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => Positive (IDExtern),
                                              LetzteZeileExtern      => Positive (IDExtern),
                                              AbstandAnfangExtern    => GlobaleTexte.Leer,
                                              AbstandMitteExtern     => GlobaleTexte.Leer,
                                              AbstandEndeExtern      => GlobaleTexte.Leer);
               
               Text := To_Unbounded_Wide_Wide_String (Source => "T");
         end case;
      
      else
         case
           IDExtern
         is
            when EinheitenKonstanten.LeerID =>
               Fehler.LogikStopp (FehlermeldungExtern => "EinheitenBeschreibungen.BeschreibungKurz - Einheit sollte existieren tut sie aber nicht.");
               
            when others =>
               Textnummer := 2 * Positive (IDExtern) - 1;
         end case;
         
         Text := GlobaleTexte.Einheiten (Textnummer);
      end if;
      
      return To_Wide_Wide_String (Source => Text);
         
   end BeschreibungKurz;
   
   
   
   procedure BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
            return;
            
         when others =>
            null;
      end case;
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Lang,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => Positive (IDExtern),
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Leer);
      
   end BeschreibungLang;
   
   
   
   function Beschäftigung
     (ArbeitExtern : in SystemDatentypen.Tastenbelegung_Enum)
      return Wide_Wide_String
   is begin
      
      if
        GlobaleVariablen.AnzeigeArt = SystemDatentypen.Konsole
      then
         case
           ArbeitExtern
         is
            when SystemDatentypen.Leer =>
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Beschreibungen_Beschäftigung_Kurz,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 9,
                                              LetzteZeileExtern      => 9,
                                              AbstandAnfangExtern    => GlobaleTexte.Leer,
                                              AbstandMitteExtern     => GlobaleTexte.Leer,
                                              AbstandEndeExtern      => GlobaleTexte.Leer);
            
            when others =>
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Beschreibungen_Beschäftigung_Kurz,
                                              ÜberschriftZeileExtern => 0,
                                              -- Der Abzug wird für die Textanzeige benötigt. Die Konstante mal so anpassen dass sie bei Verlängerung der tastenbelegung nicht mehr kaputt geht.
                                              ErsteZeileExtern       => SystemDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - EinheitenKonstanten.EinheitBefehlAbzug,
                                              LetzteZeileExtern      => SystemDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - EinheitenKonstanten.EinheitBefehlAbzug,
                                              AbstandAnfangExtern    => GlobaleTexte.Leer,
                                              AbstandMitteExtern     => GlobaleTexte.Leer,
                                              AbstandEndeExtern      => GlobaleTexte.Leer);
         end case;
         
         Text := To_Unbounded_Wide_Wide_String (Source => "T");
         
      else
         case
           ArbeitExtern
         is
            when SystemDatentypen.Leer =>
               Text := GlobaleTexte.Beschäftigungen (17);
               
            when SystemDatentypen.Tastenbelegung_Befehle_Anzeige'Range =>
               if
                 ArbeitExtern = SystemDatentypen.Straße_Bauen
               then
                  Text := GlobaleTexte.Beschäftigungen (1);
                  
               else
                  Text := GlobaleTexte.Beschäftigungen (2 * (SystemDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - EinheitenKonstanten.EinheitBefehlAbzug) - 1);
               end if;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "EinheitenBeschreibungen.Beschäftigung - Führt keine gültige Aufgabe durch.");
         end case;
      end if;
      
      return To_Wide_Wide_String (Source => Text);
      
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
