with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with Meldungstexte;
with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with GrafikKonstanten;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessverwaltungssystemGrafik;

package body SpielmeldungenGrafik is

   -- Möglicherweise mit einer modifizierten Version von EingabenanzeigeGrafik.AnzeigeText zusammenfassen? äöü
   -- Dann müsste ich den Text, den Access, den Anzeigebereich und den View mitübergeben, ob das sinnvoll ist? äöü
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
                                         str  => To_Wide_Wide_String (Source => Meldungstexte.Meldung (MeldungExtern)));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.Spielmeldung,
                                                          PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end Spielmeldung;

end SpielmeldungenGrafik;
