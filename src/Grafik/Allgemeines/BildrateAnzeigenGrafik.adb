with Sf;

with TextaccessVariablen;
with Views;

with LeseEinstellungenGrafik;

with TextaccessverwaltungssystemEinfachGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;

package body BildrateAnzeigenGrafik is
   
   procedure Bildrate
   is
      use type Sf.sfBool;
   begin
      
      Zeitunterschied := Float (Clock - LetzteZeit);
      LetzteZeit := Clock;
      
      if
        Zeitunterschied <= 0.000_001
      then
         AktuelleBildrate := 1_000_000.00;
         
      else
         AktuelleBildrate := 1.00 / Zeitunterschied;
      end if;
              
      ZielBildrate := Float (LeseEinstellungenGrafik.Bildrate);
      
      -- Die Farbe bei VSync kann aktuell nicht grün sein, da die tatsächlich erreichte Bildrate ja niedriger sein kann als VSync.
      -- Außerdem scheint es keine Funktion zum Abrufen der aktuellen Framerate zu geben, oder? äöü
      if
        LeseEinstellungenGrafik.VSync = Sf.sfTrue
      then
         Farbe := Sf.Graphics.Color.sfWhite;
                 
      elsif
        ZielBildrate = 0.00
      then
         Farbe := Sf.Graphics.Color.sfGreen;
         
      elsif
        AktuelleBildrate < ZielBildrate / 2.00
      then
         Farbe := Sf.Graphics.Color.sfRed;
      
      elsif
        AktuelleBildrate < ZielBildrate - 2.00
      then
         Farbe := Sf.Graphics.Color.sfYellow;
         
      else
         Farbe := Sf.Graphics.Color.sfGreen;
      end if;
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Bildratenbereich.width,
                                                                                              GrafikRecordKonstanten.Bildratenbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BildratenviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Bildratenbereich);
      
      TextaccessverwaltungssystemEinfachGrafik.TextPositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.BildrateAccess,
                                                                   TextExtern       => KommazahlAlsString (KommazahlExtern => AktuelleBildrate),
                                                                   PositionExtern   => GrafikRecordKonstanten.StartView,
                                                                   FarbeExtern      => Farbe);
      
      Viewfläche.x := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.BildrateAccess,
                                                                             TextbreiteExtern => 5.00);
      
      Viewfläche.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => 5.00,
                                                                     ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
   end Bildrate;

end BildrateAnzeigenGrafik;
