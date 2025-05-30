with Ada.Exceptions; use Ada.Exceptions;

with Sf.Window.Keyboard;

with DateizugriffssystemHTSEB;
with DateisystemtestsHTSEB;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;
with TextKonstantenHTSEB;

with VerzeichnisKonstanten;
with StandardTastenbelegungDatenbank;
with TastenbelegungDatentypen;
with BefehleDatentypen;
  
with SchreibeTastenbelegungDatenbank;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenTastatureinstellungenLogik is

   procedure Tastatureinstellungen
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.Tastatureinstellungen))
      is
         when False =>
            StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DateiTastatureinstellungen,
                                                    NameExtern     => VerzeichnisKonstanten.Tastatureinstellungen);
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
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiTastatureinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Tastatureinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTastatureinstellungenLogik.Tastatureinstellungen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiTastatureinstellungen,
                                                    NameExtern     => VerzeichnisKonstanten.Tastatureinstellungen);
      
   end Tastatureinstellungen;
   
   
   
   function TastatureinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      if
        LadenPrüfenExtern = False
      then
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               return False;
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Auswählen_Enum));
         end case;
         
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Oben_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Links_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Links_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Links_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Unten_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Rechts_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Links_Oben_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Links_Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Links_Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Oben_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Rechts_Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Links_Unten_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Links_Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Links_Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Unten_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Rechts_Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Rechts_Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Ebene_Hoch_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Ebene_Hoch_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Ebene_Hoch_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Ebene_Runter_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Ebene_Runter_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Ebene_Runter_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Forschung_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Forschung_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Forschung_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Diplomatie_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Diplomatie_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Diplomatie_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Stadt_Suchen_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Stadt_Suchen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Stadt_Suchen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Stadt_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Nächste_Stadt_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Stadt_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Einheit_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Nächste_Einheit_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Einheit_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Gehe_Zu_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Gehe_Zu_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Gehe_Zu_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Runde_Beenden_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Runde_Beenden_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Runde_Beenden_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Debugmenü_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Debugmenü_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Debugmenü_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               AllgemeineBelegung (TastenbelegungDatentypen.Abwählen_Enum) := StandardTastenbelegungDatenbank.AllgemeineBelegungStandard (TastenbelegungDatentypen.Abwählen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  AllgemeineBelegung (TastenbelegungDatentypen.Abwählen_Enum));
         end case;
      
            
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Auswählen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Auswählen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Auswählen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Oben_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Links_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Links_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Links_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Unten_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Rechts_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Rechts_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Rechts_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Links_Oben_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Links_Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Links_Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Rechts_Oben_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Rechts_Oben_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Rechts_Oben_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Links_Unten_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Links_Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Links_Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Rechts_Unten_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Rechts_Unten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Rechts_Unten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Ebene_Hoch_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Ebene_Hoch_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Ebene_Hoch_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Ebene_Runter_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Ebene_Runter_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Ebene_Runter_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Straße_Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Straße_Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Straße_Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Mine_Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Mine_Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Mine_Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Farm_Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Farm_Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Farm_Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Festung_Bauen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Festung_Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Festung_Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Wald_Aufforsten_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Wald_Aufforsten_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Wald_Aufforsten_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Roden_Trockenlegen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Roden_Trockenlegen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Roden_Trockenlegen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Feldeffekte_Entfernen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Feldeffekte_Entfernen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Feldeffekte_Entfernen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Heilen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Heilen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Heilen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Verschanzen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Verschanzen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Verschanzen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Plündern_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Plündern_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Plündern_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Auflösen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Auflösen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Auflösen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Einheit_Verbessern_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Einheit_Verbessern_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Einheit_Verbessern_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Heimatstadt_Ändern_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Heimatstadt_Ändern_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Heimatstadt_Ändern_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Entladen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Entladen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Entladen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Einheitenbelegung (BefehleDatentypen.Abwählen_Enum) := StandardTastenbelegungDatenbank.EinheitenbelegungStandard (BefehleDatentypen.Abwählen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Einheitenbelegung (BefehleDatentypen.Abwählen_Enum));
         end case;
            
      
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Stadtkarte_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Stadtkarte_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Stadtbelegung (BefehleDatentypen.Stadtkarte_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Bauen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Bauen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Stadtbelegung (BefehleDatentypen.Bauen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Verkaufen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Verkaufen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Stadtbelegung (BefehleDatentypen.Verkaufen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Umbenennen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Umbenennen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Stadtbelegung (BefehleDatentypen.Umbenennen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Auflösen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Auflösen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Stadtbelegung (BefehleDatentypen.Auflösen_Enum));
         end case;

         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Stadtbelegung (BefehleDatentypen.Verlassen_Enum) := StandardTastenbelegungDatenbank.StadtbelegungStandard (BefehleDatentypen.Verlassen_Enum);
            
            when False =>
               Sf.Window.Keyboard.sfKeyCode'Read (Stream (File => DateiLadenExtern),
                                                  Stadtbelegung (BefehleDatentypen.Verlassen_Enum));
         end case;
         
         -- Diese Prüfung muss am Ende aller Einlesefunktionen stehen, um sicher zu sein dass die Datei vollständig eingelesen wurde!
         -- Sollte Probleme mit geänderten Datentypen teilweise vorbeugen.
         return End_Of_File (File => DateiLadenExtern);
      
      else
         
         DoppelbelegungEntfernen;
         
         SchreibeTastenbelegungDatenbank.GesamteAllgemeineTastenbelegung (BelegungExtern => AllgemeineBelegung);
         SchreibeTastenbelegungDatenbank.GesamteEinheitenbelegung (BelegungExtern => Einheitenbelegung);
         SchreibeTastenbelegungDatenbank.GesamteStadtbelegung (BelegungExtern => Stadtbelegung);
      
         return True;
      end if;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTastatureinstellungenLogik.TastatureinstellungenDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end TastatureinstellungenDurchgehen;
   
   
   
   -- Bei einem Erweitern der möglichen Befehle im Spiel und der Verwendung einer alten Tastenbelegungsdatei kann es zu ungewollter Doppelbelegung kommen, diese wird hier geprüft/entfernt.
   procedure DoppelbelegungEntfernen
   is
      use type TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
      use type Sf.Window.Keyboard.sfKeyCode;
      use type BefehleDatentypen.Einheitenbelegung_Enum;
      use type BefehleDatentypen.Stadtbefehle_Enum;
   begin
      
      AllgemeineAußenSchleife:
      for AllgemeineAußenSchleifenwert in AllgemeineBelegung'Range loop
         AllgemeineInnenSchleife:
         for AllgemeineInnenSchleifenwert in AllgemeineAußenSchleifenwert .. AllgemeineBelegung'Last loop
            
            if
              AllgemeineAußenSchleifenwert = AllgemeineInnenSchleifenwert
            then
               null;
               
            elsif
              AllgemeineBelegung (AllgemeineAußenSchleifenwert) = AllgemeineBelegung (AllgemeineInnenSchleifenwert)
            then
               AllgemeineBelegung (AllgemeineInnenSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
               
            else
               null;
            end if;
            
         end loop AllgemeineInnenSchleife;
      end loop AllgemeineAußenSchleife;
      
      
      
      EinheitenAußenSchleife:
      for EinheitenAußenSchleifenwert in Einheitenbelegung'Range loop
         EinheitenInnenSchleife:
         for EinheitenInnenSchleifenwert in EinheitenAußenSchleifenwert .. Einheitenbelegung'Last loop
            
            if
              EinheitenAußenSchleifenwert = EinheitenInnenSchleifenwert
            then
               null;
               
            elsif
              Einheitenbelegung (EinheitenAußenSchleifenwert) = Einheitenbelegung (EinheitenInnenSchleifenwert)
            then
               Einheitenbelegung (EinheitenInnenSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
               
            else
               null;
            end if;
            
         end loop EinheitenInnenSchleife;
      end loop EinheitenAußenSchleife;
      
      
      
      StadtAußenSchleife:
      for StadtAußenSchleifenwert in Stadtbelegung'Range loop
         StadtInnenSchleife:
         for StadtInnenSchleifenwert in StadtAußenSchleifenwert .. Stadtbelegung'Last loop
            
            if
              StadtAußenSchleifenwert = StadtInnenSchleifenwert
            then
               null;
               
            elsif
              Stadtbelegung (StadtAußenSchleifenwert) = Stadtbelegung (StadtInnenSchleifenwert)
            then
               Stadtbelegung (StadtInnenSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
               
            else
               null;
            end if;
            
         end loop StadtInnenSchleife;
      end loop StadtAußenSchleife;
      
   end DoppelbelegungEntfernen;

end EinlesenTastatureinstellungenLogik;
