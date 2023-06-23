with Sf;

with TextaccessVariablen;
with Views;

with LeseEinstellungenGrafik;

with TextaccessverwaltungssystemGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;

package body BildrateAnzeigenGrafik is
   
   -- Eine Anzeige einbauen bei der die wissenschaftliche Anzeige verwendet wird? äöü
   -- Generell wieder als Float anzeigen? äöü
   procedure Bildrate
   is begin
      
      Zeitunterschied := Float (Clock - LetzteZeit);
      LetzteZeit := Clock;
      
      if
        Zeitunterschied = 0.00
      then
         AktuelleBildrate := 1;
         
      elsif
        Float'Floor (1.00 / Zeitunterschied) < 1.00
      then
         AktuelleBildrate := 1;
         
      else
         AktuelleBildrate := Positive (Float'Floor (1.00 / Zeitunterschied));
      end if;
              
      ZielBildrate := Natural (LeseEinstellungenGrafik.Bildrate);
      
      if
        ZielBildrate = 0
      then
         Farbe := Sf.Graphics.Color.sfGreen;
         
      elsif
        AktuelleBildrate < ZielBildrate / 2
      then
         Farbe := Sf.Graphics.Color.sfRed;
      
      elsif
        AktuelleBildrate < ZielBildrate - 1
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
      
      TextaccessverwaltungssystemGrafik.TextPositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.BildrateAccess,
                                                                   TextExtern       => AktuelleBildrate'Wide_Wide_Image,
                                                                   PositionExtern   => (5.00, 5.00),
                                                                   FarbeExtern      => Farbe);
      
      Viewfläche.x := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.BildrateAccess,
                                                                             TextbreiteExtern => 5.00);
      
      Viewfläche.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => 5.00,
                                                                     TextAccessExtern => TextaccessVariablen.BildrateAccess,
                                                                     ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
   end Bildrate;

end BildrateAnzeigenGrafik;
