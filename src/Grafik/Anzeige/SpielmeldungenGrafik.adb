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

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with EinstellungenGrafik;

package body SpielmeldungenGrafik is

   -- Möglicherweise mit einer modifizierten Version von EingabenanzeigeGrafik.AnzeigeText zusammenfassen? äöü
   procedure Spielmeldung
     (MeldungExtern : in Positive)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.05));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MeldungssviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Meldungsbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Meldung_Hintergrund_Enum,
                                   AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.Spielmeldung,
                                         str  => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => Meldungstexte.Meldung (MeldungExtern)));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                        TextbreiteExtern => 0.00);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                            ViewbreiteExtern => Viewfläche.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.Spielmeldung,
                                    position => Textposition);
            
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.Spielmeldung);
      
      Viewfläche := (Textbreite, Textposition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.Spielmeldung).height);
      
   end Spielmeldung;

end SpielmeldungenGrafik;