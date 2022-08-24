pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with MenueDatentypen;

with Auswahlaufteilungen;
with SchreibenTastatur;
with EingabeSFML;
with Fehler;
with RueckgabeMenues;

package body OptionenSteuerung is

   function SteuerungBelegen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      BelegungSchleife:
      loop
                  
         AuswahlWert := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Steuerung_Menü_Enum);
         
         case
           AuswahlWert
         is   
            when RueckgabeDatentypen.Speichern_Enum =>
               SchreibenTastatur.TastenbelegungSchreiben;
               
            when RueckgabeDatentypen.Wiederherstellen_Enum =>
               EingabeSFML.StandardTastenbelegungLaden;
               -- Das Schreiben rauswerfen oder durch zusätzliche Abfrage erweitern? äöü
               SchreibenTastatur.TastenbelegungSchreiben;
            
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
                     
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSteuerung.SteuerungBelegen - Falsche Menüauswahl.");
         end case;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;
      
   
   
   procedure AlteTasteEntfernenSFML
   is begin
               
      NeueAuswahl := TastenbelegungDatentypen.Tastenbelegung_Enum'Val (RueckgabeMenues.UmbelegungNummer);
      -- Das hier später entfernen.
      Put_Line (Item => NeueAuswahl'Wide_Wide_Image);
      
      NeueTasteSchleife:
      loop
         
         -- Hier nicht mehr direkt darauf zugreifen sondern so wie in allen anderen Menüs. äöü
         -- EingabeSystemeSFML.TastenEingabe; äöü
         -- NeueTasteSFML := EingabeSystemeSFML.TastaturTaste; äöü
         
         case
           NeueTasteSFML
         is
            when Sf.Window.Keyboard.sfKeyUnknown =>
               null;
               
            when Sf.Window.Keyboard.sfKeyEscape =>
               return;
               
            when others =>
               exit NeueTasteSchleife;
         end case;
         
      end loop NeueTasteSchleife;
               
     -- BelegungFeldSchleife:
    --  for BelegungFeldSchleifenwert in EingabeSFML.TastenbelegungArray'Range (1) loop
    --     BelegungPositionSchleife:
    --     for BelegungPositionSchleifenwert in EingabeSFML.TastenbelegungArray'Range (2) loop
            
     --       if
     --         EingabeSFML.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) = NeueTasteSFML
      --        and
    --            BelegungPositionSchleifenwert /= NeueAuswahl
    --        then
    --           EingabeSFML.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
               
     --       else
     --          null;
     --       end if;
            
     --    end loop BelegungPositionSchleife;
   --   end loop BelegungFeldSchleife;
      
      NeueTasteFestlegenSFML;
      
   end AlteTasteEntfernenSFML;
   
   
   
   procedure NeueTasteFestlegenSFML
   is begin
         
    --  if
    --    EingabeSFML.Tastenbelegung (Boolean'First, NeueAuswahl) = NeueTasteSFML
    --    or
   --       EingabeSFML.Tastenbelegung (Boolean'Last, NeueAuswahl) = NeueTasteSFML
    --  then
    --     null;
            
   --   elsif
   --     EingabeSFML.Tastenbelegung (Boolean'First, NeueAuswahl) = Sf.Window.Keyboard.sfKeyUnknown
   --   then
   --      EingabeSFML.Tastenbelegung (Boolean'First, NeueAuswahl) := NeueTasteSFML;
            
   --   elsif
   --     EingabeSFML.Tastenbelegung (Boolean'Last, NeueAuswahl) = Sf.Window.Keyboard.sfKeyUnknown
   --   then
    --     EingabeSFML.Tastenbelegung (Boolean'Last, NeueAuswahl) := NeueTasteSFML;
            
    --  else
    --     EingabeSFML.Tastenbelegung (Boolean'Last, NeueAuswahl) := EingabeSFML.Tastenbelegung (Boolean'First, NeueAuswahl);
    --     EingabeSFML.Tastenbelegung (Boolean'First, NeueAuswahl) := NeueTasteSFML;
    --  end if;
    
      null;
      
   end NeueTasteFestlegenSFML;

end OptionenSteuerung;
