pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with KartenRecords; use KartenRecords;
with KartengrundDatentypen; use KartengrundDatentypen;

with LeseKarten;

with GrafikEinstellungenSFML;
with KartenAllgemein;
with AufgabenAllgemein;
with TextberechnungenHoeheSFML;

package body KarteAllgemeinesSFML is

   function AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition := TextpositionExtern;
      
      AktuelleKoordinaten := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
      VorhandenerGrund := LeseKarten.VorhandenerGrund (KoordinatenExtern => AktuelleKoordinaten);
      
      TextAnzeigen (1) := True;
      
      if
        VorhandenerGrund.BasisGrund = VorhandenerGrund.AktuellerGrund
      then
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                            str  => KartenAllgemein.BeschreibungBasisgrund (KartenGrundExtern => VorhandenerGrund.AktuellerGrund));
            
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                       position => Textposition);
         
      else
         -- Für " - " mal ein einzulesendes Wort einbauen.
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                            str  => KartenAllgemein.BeschreibungBasisgrund (KartenGrundExtern => VorhandenerGrund.BasisGrund) & " - "
                                            & KartenAllgemein.BeschreibungZusatzgrund (KartenGrundExtern => VorhandenerGrund.AktuellerGrund));
      
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                       position => Textposition);
      end if;
      
      -- Da irgendwie einrücken? äöü
      -- Textposition.x := Textposition.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAllgemeinesAccess (1)).width + 5.00;      
      -- Textposition.x := TextpositionExtern.x;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      
      -- Eventuell auch mehr Wörter zusammenfassen? äöü
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            TextAnzeigen (2) := False;
            
         when others =>
            TextAnzeigen (2) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (2),
                                               str  => KartenAllgemein.BeschreibungRessource (KartenRessourceExtern => KartenRessource));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (2),
                                          position => Textposition);
      
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      end case;
      
      
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            TextAnzeigen (3) := False;
            
         when others =>
            TextAnzeigen (3) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (3),
                                               str  => AufgabenAllgemein.BeschreibungVerbesserung (KartenVerbesserungExtern => KartenVerbesserung));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (3),
                                          position => Textposition);
            
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      end case;
      
      
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            TextAnzeigen (4) := False;
            
         when others =>
            TextAnzeigen (4) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (4),
                                               str  => AufgabenAllgemein.BeschreibungWeg (KartenWegExtern => KartenWeg));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (4),
                                          position => Textposition);
      
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      end case;
      
      
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            TextAnzeigen (5) := False;
            
         when others =>
            TextAnzeigen (5) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (5),
                                               str  => KartenAllgemein.BeschreibungFluss (KartenFlussExtern => KartenFluss));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (5),
                                          position => Textposition);
      
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      end case;
      
      Textposition.y := Textposition.y - TextberechnungenHoeheSFML.KleinerZeilenabstand;
         
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
