with LeseStadtGebaut;

with KartenfelderwerteLogik;

package body StadtfeldBewertenLogik is

   function FeldBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return NahrungBewertung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                               KoordinatenExtern        => KoordinatenExtern,
                               BelegenEntfernenExtern   => BelegenEntfernenExtern)
        + ProduktionBewertung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                               KoordinatenExtern        => KoordinatenExtern,
                               BelegenEntfernenExtern   => BelegenEntfernenExtern)
        + GeldBewertung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                         KoordinatenExtern        => KoordinatenExtern,
                         BelegenEntfernenExtern   => BelegenEntfernenExtern)
        + WissenBewertung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                           KoordinatenExtern        => KoordinatenExtern,
                           BelegenEntfernenExtern   => BelegenEntfernenExtern);
      
   end FeldBewerten;
   
   
   
   function NahrungBewertung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      NahrungGesamt := KartenfelderwerteLogik.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                           SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) <= 1
        and
          NahrungGesamt >= 1
      then
         case
           BelegenEntfernenExtern
         is
            when True =>
               return 100 + (NahrungGesamt * 50);
               
            when False =>
               return -100 - (NahrungGesamt * 50);
         end case;
         
      else
         case
           BelegenEntfernenExtern
         is
            when True =>
               return NahrungGesamt;
               
            when False =>
               return -NahrungGesamt;
         end case;
      end if;
      
   end NahrungBewertung;
   
   
   
   function ProduktionBewertung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      RessourcenGesamt := KartenfelderwerteLogik.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                 SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);
      
      if
        LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) <= 0
        and
          RessourcenGesamt >= 1
      then
         case
           BelegenEntfernenExtern
         is
            when True =>
               return 25 + RessourcenGesamt;
               
            when False =>
               return -25 - RessourcenGesamt;
         end case;
         
      else
         case
           BelegenEntfernenExtern
         is
            when True =>
               return RessourcenGesamt;
               
            when False =>
               return -RessourcenGesamt;
         end case;
      end if;
      
   end ProduktionBewertung;



   function GeldBewertung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      GeldGesamt := KartenfelderwerteLogik.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                     SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);

      if
        LeseStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) <= 0
        and
          GeldGesamt >= 1
      then
         case
           BelegenEntfernenExtern
         is
            when True =>
               return 25 + GeldGesamt;
               
            when False =>
               return -25 - GeldGesamt;
         end case;
         
      else
         case
           BelegenEntfernenExtern
         is
            when True =>
               return GeldGesamt;
               
            when False =>
               return -GeldGesamt;
         end case;
      end if;

   end GeldBewertung;
   
   
   
   function WissenBewertung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin

      WissenGesamt := KartenfelderwerteLogik.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                         SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);
      
      if
        LeseStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) = 0
        and
          WissenGesamt >= 1
      then
         case
           BelegenEntfernenExtern
         is
            when True =>
               return 25 + WissenGesamt;
               
            when False =>
               return -25 - WissenGesamt;
         end case;
      
      else
         case
           BelegenEntfernenExtern
         is
            when True =>
               return WissenGesamt;
               
            when False =>
               return -WissenGesamt;
         end case;
      end if;
      
   end WissenBewertung;

end StadtfeldBewertenLogik;
