pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GrafikEinstellungenSFML;
with AllgemeineTextBerechnungenSFML;
with TextaccessVariablen;

package body AnzeigeSprachauswahlSFML is
   
   procedure AnzeigeSprache
   is begin
      
      MehrereSeiten := AuswahlSprache.MehrereSeiten;
      AktuelleAuswahl := AuswahlSprache.AktuelleAuswahl;
      Ende := AuswahlSprache.Ende;
      AktuelleSprachen := AuswahlSprache.AktuelleSprachen;
      ZeilenAbstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      YPosition := StartPositionYAchse;
            
      AnzeigeSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'First .. Ende loop
         
         if
           AktuelleAuswahl = ZeileSchleifenwert
         then
            AktuelleTextFarbe := GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
            
         else
            AktuelleTextFarbe := GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText;
         end if;
         
         if
           MehrereSeiten = False
           or
             (MehrereSeiten
              and
                ZeileSchleifenwert < Ende)
         then
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SprachauswahlAccess,
                                               str  => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SprachauswahlAccess,
                                          position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess), YPosition));
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SprachauswahlAccess,
                                       color => AktuelleTextFarbe);
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.SprachauswahlAccess);
         
            YPosition := YPosition + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.SprachauswahlAccess).height + 3.00 * ZeilenAbstand;
            
         elsif
           MehrereSeiten
           and
             ZeileSchleifenwert = Ende
         then
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
            Sf.Graphics.ConvexShape.setPosition (shape    => PfeilAccess,
                                                 position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess), YPosition + 15.00));
            Sf.Graphics.ConvexShape.setFillColor (shape => PfeilAccess,
                                                  color => AktuelleTextFarbe);
            Sf.Graphics.RenderWindow.drawConvexShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                      object       => PfeilAccess);
            
         else
            null;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeSprache;

end AnzeigeSprachauswahlSFML;
