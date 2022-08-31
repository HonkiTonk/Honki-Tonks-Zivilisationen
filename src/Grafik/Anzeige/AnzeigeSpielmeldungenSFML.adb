pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Meldungstexte;
with Views;
with GrafikDatentypen;
with TextKonstanten;
with TextaccessVariablen;

with ViewsEinstellenSFML;
with HintergrundSFML;
with TextberechnungenBreiteSFML;
with GrafikEinstellungenSFML;

package body AnzeigeSpielmeldungenSFML is

   -- Möglicherweise mit einer modifizierten Version von AnzeigeEingabeSFML.AnzeigeText zusammenfassen? äöü
   procedure Spielmeldung
     (MeldungExtern : in Positive)
   is begin
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.05));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.MeldungssviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Meldungsbereich);
      
      HintergrundSFML.Hintergrund (HintergrundExtern => GrafikDatentypen.Meldung_Hintergrund_Enum,
                                   AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.Spielmeldung,
                                         str  => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => Meldungstexte.Meldung (MeldungExtern)));
      
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                        TextbreiteExtern => 0.00);
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                            ViewbreiteExtern => Viewfläche.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.Spielmeldung,
                                    position => Textposition);
            
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.Spielmeldung);
      
      Viewfläche := (Textbreite, Textposition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.Spielmeldung).height);
      
   end Spielmeldung;

end AnzeigeSpielmeldungenSFML;
