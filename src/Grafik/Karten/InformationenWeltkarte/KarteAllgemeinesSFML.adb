pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with KartenRecords; use KartenRecords;
with KartengrundDatentypen; use KartengrundDatentypen;
with Views;
with GrafikRecordKonstanten;
with GrafikDatentypen;
with Meldungstexte;
with TextnummernKonstanten;

with LeseKarten;

with GrafikEinstellungenSFML;
with KartenAllgemein;
with AufgabenAllgemein;
with TextberechnungenHoeheSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;
with TextberechnungenBreiteSFML;

package body KarteAllgemeinesSFML is
   
   procedure Leer
   is begin
      
      -- Diese Bereiche sicherheitshalber auch von außen hineingeben? äöü
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.SeitenleisteWeltkarteAccesse (2),
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (2));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
      
   end Leer;
   
   

   procedure AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.15, 0.05));
      
      Leer;
      
      Textbreite := 0.00;
      Textposition := TextKonstanten.StartpositionText;
      RealeYPosition := Textposition.y;
      
      AktuelleKoordinaten := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      VorhandenerGrund := LeseKarten.VorhandenerGrund (KoordinatenExtern => AktuelleKoordinaten);
      
      TextAnzeigen (1) := True;
      
      if
        VorhandenerGrund.BasisGrund = VorhandenerGrund.AktuellerGrund
      then
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                            str  => KartenAllgemein.BeschreibungBasisgrund (KartenGrundExtern => VorhandenerGrund.AktuellerGrund));
         
      else
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                            str  => KartenAllgemein.BeschreibungBasisgrund (KartenGrundExtern => VorhandenerGrund.BasisGrund) & " "
                                            &  To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugMit)) & " "
                                            & KartenAllgemein.BeschreibungZusatzgrund (KartenGrundExtern => VorhandenerGrund.AktuellerGrund));
      end if;
      
      -- Eventuell auch mehr Wörter zusammenfassen? äöü
      -- Z.B. Ressourcen und Flüsse, Verbesserungen und Straßen. äöü
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
      end case;
               
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         case
           TextAnzeigen (TextSchleifenwert)
         is
            when True =>
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                             position => (Textposition.x, RealeYPosition));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert));
         
               Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                                 TextbreiteExtern => Textbreite);
               
               RealeYPosition := RealeYPosition + TextberechnungenHoeheSFML.Zeilenabstand;
               
            when False =>
               null;
         end case;
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
      end loop TextSchleife;
            
      Viewfläche := (Textbreite, Textposition.y);

   end AllgemeineInformationen;

end KarteAllgemeinesSFML;
