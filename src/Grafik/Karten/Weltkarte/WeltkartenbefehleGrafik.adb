pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Views;
with GrafikDatentypen;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;

-- Zwei Viewflächen anlegen? Wäre das eventuell sinnvoll bei späteren Doppelaufrufen? äöü
package body WeltkartenbefehleGrafik is

   procedure Kartenbefehle
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (1.00, 1.00));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.KartenbefehlsviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Kartenbefehlsbereich);
      
      -- Für die Anzeige noch einen eigenen Hintergrund einbauen. äöü
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      Textbreite := 0.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in 1 .. 1 loop
         
         null;
         
      end loop PositionenSchleife;

      Viewfläche := (Textbreite, Textposition.y);
      
   end Kartenbefehle;
   
   
   
   procedure Einheitenbefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      -- Auf Basis der Einheit die Befehlsknöpfe sperren? äöü
      -- Oder einfach alle Anzeigen und bei den ungültigen nichts tun? äöü
      -- Einfach zurückgeben und die bereits vorhandenen Prüfungen durchlaufen lassen? äöü
      
      if
        EinheitRasseNummerExtern.Rasse = RassenDatentypen.Keine_Rasse_Enum
      then
         null;
         
      else
         null;
      end if;
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (1.00, 1.00));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.EinheitenbefehlsviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Einheitenbefehlsbereich);
      
      -- Für die Anzeige noch einen eigenen Hintergrund einbauen. äöü
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      Textbreite := 0.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in 1 .. 1 loop
         
         null;
         
      end loop PositionenSchleife;

      Viewfläche := (Textbreite, Textposition.y);
      
   end Einheitenbefehle;

end WeltkartenbefehleGrafik;
