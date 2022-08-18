pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GrafikKonstanten;
with GrafikDatentypen;
with TextKonstanten;
with InteraktionAuswahl;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with TextaccessVariablen;
with TextberechnungenHoeheSFML;
with TexteinstellungenSFML;
with NachGrafiktask;
with ViewsEinstellenSFML;
with ViewsSFML;
with HintergrundSFML;

package body AnzeigeSprachauswahlSFML is
   
   procedure AnzeigeSprache
   is begin
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      Viewfläche := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.MenüviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikKonstanten.StandardAnzeigebereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
      
      case
        Erstaufruf
      is
         when True =>
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                      font => TexteinstellungenSFML.SchriftartAccess);
            Erstaufruf := False;
            
         when False =>
            null;
      end case;
      
      -- Diese Werter später in die Prozedur übergeben, außer die Sprachen? äöü
      MehrereSeiten := NachGrafiktask.MehrereSeiten;
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl;
      Ende := NachGrafiktask.Endauswahl;
      AktuelleSprachen := AuswahlSprache.AktuelleSprachen;
      
      Textposition := TextKonstanten.StartpositionText;
      AktuelleTextbreite := 0.00;
      
      -- Dann einfach von 1 bis 11 loopen und entsprechend leer lassen, sollte hinhauen. äöü
      AnzeigeSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'First .. Ende loop
         
         if
           AktuelleAuswahl = ZeileSchleifenwert
         then
            AktuelleTextFarbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
            
         else
            AktuelleTextFarbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
         end if;
         
         if
           MehrereSeiten = False
           or
             (MehrereSeiten
              and
                ZeileSchleifenwert < Ende)
         then
            -- Alle Textaccesse nach dem Erzeugen des Fenster setzen und dann noch einmal nach der Sprachauswahl? äöü
            -- Dann würde alles doppelt gesetzt werden, dafür müsste ich hier weniger einstellen. äöü
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SprachauswahlAccess,
                                               str  => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SprachauswahlAccess,
                                       color => AktuelleTextFarbe);
            
            Textposition.x := Viewfläche.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess);
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SprachauswahlAccess,
                                          position => Textposition);
            
            NeueTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SprachauswahlAccess).width;
            
            InteraktionAuswahl.PositionenSprachauswahl (ZeileSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SprachauswahlAccess);
            
            -- Den Textteil in ein Array packen und bei leeren Zeilen einfach nichts darstellen? äöü
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.SprachauswahlAccess);
                        
         elsif
           MehrereSeiten
           and
             ZeileSchleifenwert = Ende
         then
            -- Das später wie bei der Versionsnummer regeln? Dafür dann auch mal eine universellere Lösung finden. äöü
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
            
            Sf.Graphics.ConvexShape.setPointCount (shape => PfeilAccess,
                                                   count => 7);
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 0,
                                              point => (0.00, 0.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 1,
                                              point => (40.00, 0.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 2,
                                              point => (40.00, -15.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 3,
                                              point => (70.00, 10.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 4,
                                              point => (40.00, 35.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 5,
                                              point => (40.00, 20.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 6,
                                              point => (0.00, 20.00));
            
            Sf.Graphics.ConvexShape.setFillColor (shape => PfeilAccess,
                                                  color => AktuelleTextFarbe);
            
            Textposition.x := Viewfläche.x / 2.00 - 0.50 * Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess).width;
            
            Sf.Graphics.ConvexShape.setPosition (shape    => PfeilAccess,
                                                 position => Textposition);
            
            InteraktionAuswahl.PositionenSprachauswahl (ZeileSchleifenwert) := Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess);
            
            NeueTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess).width;
            
            Sf.Graphics.RenderWindow.drawConvexShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                      object       => PfeilAccess);
            
         else
            null;
         end if;
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
         if
           NeueTextbreite > AktuelleTextbreite
         then
            AktuelleTextbreite := NeueTextbreite;
            
         else
            null;
         end if;
         
      end loop AnzeigeSchleife;
      
      Viewfläche := (AktuelleTextbreite, Textposition.y);
      
   end AnzeigeSprache;

end AnzeigeSprachauswahlSFML;
