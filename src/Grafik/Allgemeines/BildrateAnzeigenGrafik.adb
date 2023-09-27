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
   is begin
      
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
      
      if
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
                                                                     ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
   end Bildrate;

end BildrateAnzeigenGrafik;
