with Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Meldungstexte;
with Views;
with GrafikDatentypen;
with TextaccessVariablen;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;

package body SpielmeldungenGrafik is

   -- Möglicherweise mit einer modifizierten Version von EingabenanzeigeGrafik.AnzeigeText zusammenfassen? äöü
   procedure Spielmeldung
     (MeldungExtern : in Positive)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Meldungsbereich.width, GrafikRecordKonstanten.Meldungsbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MeldungssviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Meldungsbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Meldung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
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
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end Spielmeldung;

end SpielmeldungenGrafik;
