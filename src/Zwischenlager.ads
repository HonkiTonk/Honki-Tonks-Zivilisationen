function Baumenü
  return StadtRecords.BauprojektRecord
is begin

   Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                              point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                              view         => Views.BauviewAccesse (ViewKonstanten.BaumenüGebäudeliste));

   case
     MausauswahlAllgemeinLogik.MauszeigerImView (MauspositionExtern => Mausposition,
                                                 BereichExtern      => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudeliste).width,
                                                                        GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudeliste).height))
   is
      when False =>
         Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                    point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                    view         => Views.BauviewAccesse (ViewKonstanten.BaumenüEinheitenliste));

      when True =>
         GebäudeSchleife:
         for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop

            case
              InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
            is
               when True =>
                  if
                    True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                       RechteckExtern     => InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert))
                  then
                     return (GebäudeSchleifenwert, EinheitenKonstanten.LeerID);

                  else
                     null;
                  end if;

               when False =>
                  null;
            end case;

         end loop GebäudeSchleife;

         return (StadtKonstanten.LeerGebäudeID, EinheitenKonstanten.LeerID);
   end case;

   case
     MausauswahlAllgemeinLogik.MauszeigerImView (MauspositionExtern => Mausposition,
                                                 BereichExtern      => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheitenliste).width,
                                                                        GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheitenliste).height))
   is
      when False =>
         null;

      when True =>
         EinheitenSchleife:
         for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenIDVorhanden'Range loop

            case
              InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
            is
               when True =>
                  if
                    True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                       RechteckExtern     => InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert))
                  then
                     return (StadtKonstanten.LeerGebäudeID, EinheitenSchleifenwert);

                  else
                     null;
                  end if;

               when False =>
                  null;
            end case;

         end loop EinheitenSchleife;
   end case;

   return (StadtKonstanten.LeerGebäudeID, EinheitenKonstanten.LeerID);

end Baumenü;
