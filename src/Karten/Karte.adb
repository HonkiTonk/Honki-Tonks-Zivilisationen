pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen;

with Karten;
with KarteInformationenKonsole;
with KarteSFML;
with KarteKonsole;
with CursorPositionAltFestlegen;
with Sichtweiten;
with KarteInformationenSFML;

package body Karte is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
      
      case
        Karten.Kartengröße
      is
         when KartenDatentypen.Karte_20_20 =>
            Sichtweiten.SichtweiteFestlegen := 1;
            Sichtweiten.BewegungsfeldFestlegen := 1;
            
         when KartenDatentypen.Karte_40_40 =>
            Sichtweiten.SichtweiteFestlegen := 2;
            Sichtweiten.BewegungsfeldFestlegen := 2;

         when KartenDatentypen.Karte_Nutzer =>
            if
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (KartenDatentypen.Karte_20_20).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (KartenDatentypen.Karte_20_20).XAchsenGröße
            then
               Sichtweiten.SichtweiteFestlegen := 1;
               Sichtweiten.BewegungsfeldFestlegen := 1;
               
            elsif
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (KartenDatentypen.Karte_40_40).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (KartenDatentypen.Karte_40_40).XAchsenGröße
            then
               Sichtweiten.SichtweiteFestlegen := 2;
               Sichtweiten.BewegungsfeldFestlegen := 2;
               
            else
               Sichtweiten.SichtweiteFestlegen := 3;
               Sichtweiten.BewegungsfeldFestlegen := 3;
            end if;
            
         when others =>
            Sichtweiten.SichtweiteFestlegen := 3;
            Sichtweiten.BewegungsfeldFestlegen := 3;
      end case;
      
   end SichtweiteBewegungsfeldFestlegen;
   
   

   procedure AnzeigeKarte
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      CursorPositionAltFestlegen.CursorPositionAltFestlegen (RasseExtern                  => RasseExtern,
                                                             -- Ist das hier noch nötig oder kann das raus?
                                                             BewegungsfeldFestlegenExtern => Sichtweiten.BewegungsfeldFestlegen);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole | SystemDatentypen.Beides =>
            KarteKonsole.AnzeigeKarteKonsole (RasseExtern => RasseExtern);
            KarteInformationenKonsole.KarteInformationenKonsole (RasseExtern => RasseExtern);
            
         when SystemDatentypen.SFML =>
            null;
      end case;
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            KarteSFML.KarteAnzeigen (RasseExtern => RasseExtern);
            KarteInformationenSFML.KarteInformationenSFML (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Konsole =>
            null;
      end case;

   end AnzeigeKarte;
   
end Karte;
