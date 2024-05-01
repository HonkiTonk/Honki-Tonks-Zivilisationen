-- Wäre das so sinnvoller als das bisherige System? äöü
ViewbereichBeschreibung.Viewbereich := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewbereichBeschreibung.Viewbereich,
                                                                                          VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung).width,
                                                                                                                GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung).height));

if
  ViewbereichBeschreibung.Viewbereich /= ViewbereichBeschreibung.ViewbereichAlt
then
   ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüBeschreibung),
                                         GrößeExtern          => ViewbereichBeschreibung.Viewbereich,
                                         AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung));

   ViewbereichBeschreibung.ViewbereichAlt := ViewbereichBeschreibung.Viewbereich;

else
   ViewsEinstellenGrafik.ViewSetzen (ViewExtern => Views.BauviewAccesse (ViewKonstanten.BaumenüBeschreibung));
end if;

HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                               AbmessungenExtern => ViewbereichBeschreibung.Viewbereich);




Könnte Ada.Strings.UTF_Encoding.Conversions bei Windows mit den Ordnernamen helfen?
