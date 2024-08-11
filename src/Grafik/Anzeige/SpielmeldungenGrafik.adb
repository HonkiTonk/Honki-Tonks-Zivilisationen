with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with Spieltexte;
with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with GrafikKonstanten;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessverwaltungssystemEinfachGrafik;

package body SpielmeldungenGrafik is

   -- Kann ich solche Konstrukte zusammenfassen, wenn ich einfach alles was wichtig ist übergebe? äöü
   procedure Spielmeldung
     (MeldungExtern : in Positive)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Meldungsbereich.width, GrafikRecordKonstanten.Meldungsbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MeldungsviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Meldungsbereich);
            
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Hinweis_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.Spielmeldung,
                                         str  => To_Wide_Wide_String (Source => Spieltexte.Meldungen (MeldungExtern)));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.Spielmeldung,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.Spielmeldung,
                                                          PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end Spielmeldung;

end SpielmeldungenGrafik;
