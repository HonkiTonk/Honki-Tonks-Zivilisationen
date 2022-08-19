pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with TextKonstanten;
with TextaccessVariablen;
with ViewsSFML;

with TextberechnungenBreiteSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;
with GrafikEinstellungenSFML;

package body UeberschriftviewSFML is
      
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum)
   is begin
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ÜberschriftviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => Anzeigebereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => HintergrundExtern,
                                        AbmessungenExtern => Viewfläche);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => ÜberschriftExtern);
      
      TextPosition.x := Viewfläche.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess);
      TextPosition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ÜberschriftAccess,
                                    position => TextPosition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);

      Viewfläche := (TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).width,
                      TextPosition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).height);
         
   end Überschrift;

end UeberschriftviewSFML;
