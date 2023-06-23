with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with Sf.Window.Keyboard;

with VerzeichnisKonstanten;
with StandardTastenbelegungDatenbank;
with TastenbelegungDatentypen;
with BefehleDatentypen;

with SchreibeTastenbelegungDatenbank;

with Fehlermeldungssystem;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenTastatureinstellungenLogik is

   procedure Tastatureinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Tastatureinstellungen)
      is
         when False =>
            StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
            return;
            
         when True =>
            Open (File => DateiTastatureinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Tastatureinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        TastatureinstellungenDurchgehen (LadenPrüfenExtern => False,
                                         DateiLadenExtern  => DateiTastatureinstellungen)
      is
         when True =>
            Nullwert := TastatureinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                         DateiLadenExtern  => DateiTastatureinstellungen);
            
         when False =>
            StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
      end case;
      
      Close (File => DateiTastatureinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTastatureinstellungenLogik.Tastatureinstellungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
         
         case
           Is_Open (File => DateiTastatureinstellungen)
         is
            when True =>
               Close (File => DateiTastatureinstellungen);
               
            when False =>
               null;
         end case;
      
   end Tastatureinstellungen;
   
   
   
   function TastatureinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      if
        LadenPrüfenExtern = False
      then
         -- TastenbelegungDatenbank.AllgemeineBelegungArray
         -- TastenbelegungDatenbank.EinheitenbelegungArray
         -- TastenbelegungDatenbank.StadtbelegungArray
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               return False;
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Auswählen_Enum));
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Oben_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Links_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Links_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Links_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Unten_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Rechts_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Links_Oben_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Links_Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Links_Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Oben_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Rechts_Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Links_Unten_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Links_Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Links_Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Unten_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Rechts_Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Ebene_Hoch_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Ebene_Hoch_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Ebene_Hoch_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Ebene_Runter_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Ebene_Runter_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Ebene_Runter_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Forschung_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Forschung_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Forschung_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Diplomatie_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Diplomatie_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Diplomatie_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Stadt_Suchen_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Stadt_Suchen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Stadt_Suchen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Stadt_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Nächste_Stadt_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Stadt_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Einheit_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Nächste_Einheit_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Einheit_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Gehe_Zu_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Gehe_Zu_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Gehe_Zu_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Runde_Beenden_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Runde_Beenden_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Runde_Beenden_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Debugmenü_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Debugmenü_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Debugmenü_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Abwählen_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Abwählen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Abwählen_Enum));
         end case;
      
            
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Auswählen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Auswählen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Auswählen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Oben_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Links_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Links_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Links_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Unten_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Rechts_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Rechts_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Rechts_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Links_Oben_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Links_Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Links_Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Rechts_Oben_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Rechts_Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Rechts_Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Links_Unten_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Links_Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Links_Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Rechts_Unten_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Rechts_Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Rechts_Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Ebene_Hoch_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Ebene_Hoch_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Ebene_Hoch_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Ebene_Runter_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Ebene_Runter_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Ebene_Runter_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Straße_Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Straße_Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Straße_Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Mine_Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Mine_Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Mine_Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Farm_Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Farm_Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Farm_Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Festung_Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Festung_Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Festung_Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Wald_Aufforsten_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Wald_Aufforsten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Wald_Aufforsten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Roden_Trockenlegen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Roden_Trockenlegen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Roden_Trockenlegen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Feldeffekte_Entfernen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Feldeffekte_Entfernen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Feldeffekte_Entfernen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Heilen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Heilen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Heilen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Verschanzen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Verschanzen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Verschanzen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Plündern_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Plündern_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Plündern_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Auflösen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Auflösen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Auflösen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Einheit_Verbessern_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Einheit_Verbessern_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Einheit_Verbessern_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Heimatstadt_Ändern_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Heimatstadt_Ändern_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Heimatstadt_Ändern_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Entladen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Entladen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Entladen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Abwählen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Abwählen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Einheitenbelegung (BefehleDatentypen.Abwählen_Enum));
         end case;
            
      
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Stadtkarte_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Stadtkarte_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Stadtbelegung (BefehleDatentypen.Stadtkarte_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Bauen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Stadtbelegung (BefehleDatentypen.Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Verkaufen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Verkaufen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Stadtbelegung (BefehleDatentypen.Verkaufen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Umbenennen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Umbenennen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Stadtbelegung (BefehleDatentypen.Umbenennen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Auflösen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Auflösen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Stadtbelegung (BefehleDatentypen.Auflösen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Verlassen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Verlassen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiTastatureinstellungen),
                                                  Stadtbelegung (BefehleDatentypen.Verlassen_Enum));
         end case;
         -- TastenbelegungDatenbank.AllgemeineBelegungArray
         -- TastenbelegungDatenbank.EinheitenbelegungArray
         -- TastenbelegungDatenbank.StadtbelegungArray
      
      else
         SchreibeTastenbelegungDatenbank.GesamteAllgemeineTastenbelegung (BelegungExtern => AllgemeineBelegung);
         SchreibeTastenbelegungDatenbank.GesamteEinheitenbelegung (BelegungExtern => Einheitenbelegung);
         SchreibeTastenbelegungDatenbank.GesamteStadtbelegung (BelegungExtern => Stadtbelegung);
      end if;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTastatureinstellungenLogik.TastatureinstellungenDurchgehen - Konnte nicht geladen werden: "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end TastatureinstellungenDurchgehen;

end EinlesenTastatureinstellungenLogik;
