with MeldungssystemHTSEB;

with InteraktionAuswahl;
with ViewKonstanten;
with Views;
with GrafikDatentypen;
with GrafikVariablen;

with ObjekteZeichnenGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;

package body ScrollleisteGrafik is
   
   procedure Scrollen
     (BelegungslängeExtern : in Float;
      AbschnittExtern : in Natural)
   is begin
      
      ViewflächeScrollen := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeScrollen,
                                                                                                 VerhältnisExtern => (GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste).width,
                                                                                                                       GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungScrollleiste),
                                            GrößeExtern          => ViewflächeScrollen,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Hinweis_Enum,
                                    AbmessungenExtern => ViewflächeScrollen);
      
      if
        ViewflächeScrollen.y / Float (InteraktionAuswahl.PositionenSteuerungsleiste'Last) <= 10.00
      then
         null;
         
      else
         GrafikVariablen.Scrollleistenabschnitt := ViewflächeScrollen.y / Float (InteraktionAuswahl.PositionenSteuerungsleiste'Last);
      end if;
      
      Durchläufe := 1;
      
      DurchläufeSchleife:
      while BelegungslängeExtern >= GrafikVariablen.Scrollleistenabschnitt * Float (Durchläufe) loop
         
         Durchläufe := Durchläufe + 1;
         
      end loop DurchläufeSchleife;
      
      if
        Durchläufe > InteraktionAuswahl.PositionenSteuerungsleiste'Last
      then
         MeldungssystemHTSEB.Grafik (MeldungExtern => "ScrollleisteGrafik.Scrollen: Zu viele Durchläufe, erlaubt: " & InteraktionAuswahl.PositionenSteuerungsleiste'Last'Wide_Wide_Image
                                     & " notwendig: " & Durchläufe'Wide_Wide_Image);
         Durchläufe := InteraktionAuswahl.PositionenSteuerungsleiste'Last;
         
      else
         null;
      end if;
      
      Leistenabschnitt := ViewflächeScrollen.y / Float (Durchläufe);
      
      for Schleifenwert in InteraktionAuswahl.PositionenSteuerungsleiste'First .. Durchläufe loop
         
         InteraktionAuswahl.PositionenSteuerungsleiste (Schleifenwert) := (0.00, Float (Schleifenwert - 1) * Leistenabschnitt, ViewflächeScrollen.x, Leistenabschnitt);
         
      end loop;
      
      case
        Durchläufe
      is
         when InteraktionAuswahl.PositionenSteuerungsleiste'Last =>
            null;
            
         when others =>
            InteraktionAuswahl.PositionenSteuerungsleiste (Durchläufe + 1 .. InteraktionAuswahl.PositionenSteuerungsleiste'Last) := (others => GrafikRecordKonstanten.Leerbereich);
      end case;
      
      ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => (ViewflächeScrollen.x, Leistenabschnitt),
                                              PositionExtern  => (0.00, Float (AbschnittExtern) * Leistenabschnitt),
                                              FarbeExtern     => GrafikRecordKonstanten.Fehlerfarbe);
      
   end Scrollen;

end ScrollleisteGrafik;
