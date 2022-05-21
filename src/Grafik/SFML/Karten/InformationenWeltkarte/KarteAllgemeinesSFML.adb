pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with KartenRecords; use KartenRecords;
with SpielVariablen;

with LeseKarten;

with GrafikEinstellungenSFML;
with KartenAllgemein;
with AufgabenAllgemein;

package body KarteAllgemeinesSFML is

   function AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition := TextpositionExtern;
      Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      AktuelleKoordinaten := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
      KartenGrund := LeseKarten.AktuellerGrund (KoordinatenExtern => AktuelleKoordinaten);
                             
      case
        LeseKarten.Hügel (KoordinatenExtern => AktuelleKoordinaten)
      is
         when True =>
            TextAnzeigen (1) := True;
              
            if
              AktuelleKoordinaten /= LetzteKoordinaten
            then
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                                  str  => KartenAllgemein.BeschreibungGrund (KartenGrundExtern => KartengrundDatentypen.Hügel_Mit_Enum));
      
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                             position => Textposition);
         
               Textposition.x := Textposition.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAllgemeinesAccess (1)).width + 5.00;
            
            else
               null;
            end if;
         
         when False =>
            TextAnzeigen (1) := False;
      end case;
      
      TextAnzeigen (2) := True;
                     
      if
        AktuelleKoordinaten /= LetzteKoordinaten
      then
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (2),
                                            str  => KartenAllgemein.BeschreibungGrund (KartenGrundExtern => KartenGrund));
      
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (2),
                                       position => Textposition);
         
      else
         null;
      end if;
      
      Textposition.x := TextpositionExtern.x;
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAllgemeinesAccess (2)).height;
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            TextAnzeigen (3) := False;
            
         when others =>
            TextAnzeigen (3) := True;
            
            if
              AktuelleKoordinaten /= LetzteKoordinaten
            then
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (3),
                                                  str  =>
                                                    KartenAllgemein.BeschreibungRessource (KartenRessourceExtern => KartenRessource));
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (3),
                                             position => Textposition);
               
            else
               null;
            end if;
      
            Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAllgemeinesAccess (3)).height;
      end case;
      
      
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            TextAnzeigen (4) := False;
            
         when others =>
            TextAnzeigen (4) := True;
            
            if
              AktuelleKoordinaten /= LetzteKoordinaten
            then
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (4),
                                                  str  => AufgabenAllgemein.BeschreibungVerbesserung (KartenVerbesserungExtern => KartenVerbesserung));
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (4),
                                             position => Textposition);
               
            else
               null;
            end if;
      
            Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAllgemeinesAccess (4)).height;
      end case;
      
      
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            TextAnzeigen (5) := False;
            
         when others =>
            TextAnzeigen (5) := True;
            
            if
              AktuelleKoordinaten /= LetzteKoordinaten
            then
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (5),
                                                  str  => AufgabenAllgemein.BeschreibungWeg (KartenWegExtern => KartenWeg));
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (5),
                                             position => Textposition);
               
            else
               null;
            end if;
      
            Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAllgemeinesAccess (5)).height;
      end case;
      
      
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            TextAnzeigen (6) := False;
            
         when others =>
            TextAnzeigen (6) := True;
            
            if
              AktuelleKoordinaten /= LetzteKoordinaten
            then
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (6),
                                                  str  => KartenAllgemein.BeschreibungFluss (KartenFlussExtern => KartenFluss));
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (6),
                                             position => Textposition);
               
            else
               null;
            end if;
      end case;
         
      LetzteKoordinaten := AktuelleKoordinaten;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccessArray'Range loop
         
         case
           TextAnzeigen (TextSchleifenwert)
         is
            when True =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert));
               
            when False =>
               null;
         end case;
         
      end loop TextSchleife;
      
      return Textposition;

   end AllgemeineInformationen;

end KarteAllgemeinesSFML;
