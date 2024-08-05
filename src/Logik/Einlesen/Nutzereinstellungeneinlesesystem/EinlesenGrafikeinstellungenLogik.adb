with Ada.Exceptions; use Ada.Exceptions;

with Sf.Graphics.Color;

with VerzeichnisKonstanten;
with TextDatentypen;
with TextKonstanten;

with SchreibeEinstellungenGrafik;

with Fehlermeldungssystem;
with EinstellungenGrafik;
with VerzeichnisDateinamenTests;
with UmwandlungenAdaEigenes;
with DateiLogik;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
package body EinlesenGrafikeinstellungenLogik is

   procedure Grafikeinstellungen
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Grafikeinstellungen))
      is
         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
            return;
            
         when True =>
            DateiLogik.ÖffnenStream (DateiartExtern => DateiGrafikeinstellungen,
                                      NameExtern     => VerzeichnisKonstanten.Grafikeinstellungen);
      end case;
      
      case
        GrafikeinstellungenDurchgehen (LadenPrüfenExtern => False,
                                       DateiLadenExtern  => DateiGrafikeinstellungen)
      is
         when True =>
            Nullwert := GrafikeinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                       DateiLadenExtern  => DateiGrafikeinstellungen);
            
         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
      end case;
      
      Close (File => DateiGrafikeinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenGrafikeinstellungenLogik.Grafikeinstellungen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         EinstellungenGrafik.StandardeinstellungenLaden;
         
         case
           Is_Open (File => DateiGrafikeinstellungen)
         is
            when True =>
               Close (File => DateiGrafikeinstellungen);
               
            when False =>
               null;
         end case;
      
   end Grafikeinstellungen;
   
   
   
   function GrafikeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      if
        LadenPrüfenExtern = False
      then
         -- GrafikRecords.GrafikeinstellungenRecord
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               return False;
            
            when False =>
               Sf.Window.Window.sfWindowStyle'Read (Stream (File => DateiLadenExtern),
                                                    Fenstermodus);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Auflösung := EinstellungenGrafik.GrafikeinstellungenStandard.Auflösung;
            
            when False =>
               Sf.System.Vector2.sfVector2u'Read (Stream (File => DateiLadenExtern),
                                                  Auflösung);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Farbtiefe := EinstellungenGrafik.GrafikeinstellungenStandard.Farbtiefe;
            
            when False =>
               Sf.sfUint32'Read (Stream (File => DateiLadenExtern),
                                 Farbtiefe);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Bildrate := EinstellungenGrafik.GrafikeinstellungenStandard.Bildrate;
            
            when False =>
               Sf.sfUint32'Read (Stream (File => DateiLadenExtern),
                                 Bildrate);
         end case;
      
      
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftgrößen (TextDatentypen.Überschrift_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftgrößen (TextDatentypen.Überschrift_Enum);
            
            when False =>
               Sf.sfUint32'Read (Stream (File => DateiLadenExtern),
                                 Schriftgrößen (TextDatentypen.Überschrift_Enum));
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftgrößen (TextDatentypen.Standard_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftgrößen (TextDatentypen.Standard_Enum);
            
            when False =>
               Sf.sfUint32'Read (Stream (File => DateiLadenExtern),
                                 Schriftgrößen (TextDatentypen.Standard_Enum));
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftgrößen (TextDatentypen.Klein_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftgrößen (TextDatentypen.Klein_Enum);
            
            when False =>
               Sf.sfUint32'Read (Stream (File => DateiLadenExtern),
                                 Schriftgrößen (TextDatentypen.Klein_Enum));
         end case;
            
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftfarben (TextDatentypen.Überschrift_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftfarben (TextDatentypen.Überschrift_Enum);
            
            when False =>
               Sf.Graphics.Color.sfColor'Read (Stream (File => DateiLadenExtern),
                                               Schriftfarben (TextDatentypen.Überschrift_Enum));
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftfarben (TextDatentypen.Standard_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftfarben (TextDatentypen.Standard_Enum);
            
            when False =>
               Sf.Graphics.Color.sfColor'Read (Stream (File => DateiLadenExtern),
                                               Schriftfarben (TextDatentypen.Standard_Enum));
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftfarben (TextDatentypen.Ausgewählt_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftfarben (TextDatentypen.Ausgewählt_Enum);
            
            when False =>
               Sf.Graphics.Color.sfColor'Read (Stream (File => DateiLadenExtern),
                                               Schriftfarben (TextDatentypen.Ausgewählt_Enum));
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftfarben (TextDatentypen.Mensch_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftfarben (TextDatentypen.Mensch_Enum);
            
            when False =>
               Sf.Graphics.Color.sfColor'Read (Stream (File => DateiLadenExtern),
                                               Schriftfarben (TextDatentypen.Mensch_Enum));
         end case;
        
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftfarben (TextDatentypen.KI_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftfarben (TextDatentypen.KI_Enum);
            
            when False =>
               Sf.Graphics.Color.sfColor'Read (Stream (File => DateiLadenExtern),
                                               Schriftfarben (TextDatentypen.KI_Enum));
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftfarben (TextDatentypen.Sonstiges_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftfarben (TextDatentypen.Sonstiges_Enum);
            
            when False =>
               Sf.Graphics.Color.sfColor'Read (Stream (File => DateiLadenExtern),
                                               Schriftfarben (TextDatentypen.Sonstiges_Enum));
         end case;
         
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftstil := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftstil;
               
            when False =>
               Sf.Graphics.Text.sfTextStyle'Read (Stream (File => DateiLadenExtern),
                                                  Schriftstil);
         end case;
      
      
      
         -- Die Schleife kann ich hier verwenden, weil sich die Speziesanzahl nicht mehr ändern wird.
         SpeziesSchleife:
         for SpeziesSchleifenwert in SpeziesFarben'Range loop
      
            case
              End_Of_File (File => DateiLadenExtern)
            is
               when True =>
                  SpeziesFarben (SpeziesSchleifenwert) := EinstellungenGrafik.GrafikeinstellungenStandard.Speziesfarben (SpeziesSchleifenwert);
            
               when False =>
                  Sf.Graphics.Color.sfColor'Read (Stream (File => DateiLadenExtern),
                                                  SpeziesFarben (SpeziesSchleifenwert));
            end case;
               
         end loop SpeziesSchleife;
      
      
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               EbenenUnterhalbSichtbar := EinstellungenGrafik.GrafikeinstellungenStandard.EbeneUnterhalbSichtbar;
            
            when False =>
               Boolean'Read (Stream (File => DateiLadenExtern),
                             EbenenUnterhalbSichtbar);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               BildrateAnzeigen := EinstellungenGrafik.GrafikeinstellungenStandard.BildrateAnzeigen;
            
            when False =>
               Boolean'Read (Stream (File => DateiLadenExtern),
                             BildrateAnzeigen);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               VSync := EinstellungenGrafik.GrafikeinstellungenStandard.VSync;
            
            when False =>
               Sf.sfBool'Read (Stream (File => DateiLadenExtern),
                               VSync);
         end case;
      
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftfarben (TextDatentypen.Aktiver_Menübereich_Enum) := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftfarben (TextDatentypen.Aktiver_Menübereich_Enum);
            
            when False =>
               Sf.Graphics.Color.sfColor'Read (Stream (File => DateiLadenExtern),
                                               Schriftfarben (TextDatentypen.Aktiver_Menübereich_Enum));
         end case;
         
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               Schriftrahmen := EinstellungenGrafik.GrafikeinstellungenStandard.Schriftrahmen;
               
            when False =>
               Float'Read (Stream (File => DateiLadenExtern),
                           Schriftrahmen);
         end case;
         -- GrafikRecords.GrafikeinstellungenRecord
         
         -- Diese Prüfung muss am Ende aller Einlesefunktionen stehen, um sicher zu sein dass die Datei vollständig eingelesen wurde!
         -- Sollte Probleme mit geänderten Datentypen teilweise vorbeugen.
         return End_Of_File (File => DateiLadenExtern);
      
      else
         SchreibeEinstellungenGrafik.GesamteGrafikeinstellungen (EinstellungenExtern => (
                                                                                         Fenstermodus           => Fenstermodus,
                                                                           
                                                                                         Auflösung              => Auflösung,
                                                                                         Farbtiefe              => Farbtiefe,
                                                                                         Bildrate               => Bildrate,
                                                                                         VSync                  => VSync,
                                                                                      
                                                                                         Schriftgrößen          => Schriftgrößen,
                                                                                         Schriftfarben          => Schriftfarben,
                                                                                         Schriftstil            => Schriftstil,
                                                                                         Schriftrahmen          => Schriftrahmen,
                                                                                      
                                                                                         Speziesfarben          => SpeziesFarben,
                                                                                                          
                                                                                         EbeneUnterhalbSichtbar => EbenenUnterhalbSichtbar,
                                                                                         BildrateAnzeigen       => BildrateAnzeigen
                                                                                        ));
      
         return True;
      end if;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenGrafikeinstellungenLogik.GrafikeinstellungenDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end GrafikeinstellungenDurchgehen;

end EinlesenGrafikeinstellungenLogik;
