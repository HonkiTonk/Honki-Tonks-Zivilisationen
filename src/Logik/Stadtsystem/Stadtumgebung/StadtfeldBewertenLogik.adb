with LeseStadtGebaut;

with FeldproduktionLogik;

package body StadtfeldBewertenLogik is

   function FeldBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      NahrungGesamt := FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KoordinatenExtern,
                                                           SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                           ProduktionsartExtern => ProduktionDatentypen.Nahrung_Enum);
      
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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      RessourcenGesamt := FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KoordinatenExtern,
                                                              SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                              ProduktionsartExtern => ProduktionDatentypen.Material_Enum);
      
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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        StadtSpeziesNummerExtern.Spezies
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            return 0;
            
         when others =>
            GeldGesamt := FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KoordinatenExtern,
                                                              SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                              ProduktionsartExtern => ProduktionDatentypen.Geld_Enum);
      end case;

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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin

      WissenGesamt := FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KoordinatenExtern,
                                                          SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                          ProduktionsartExtern => ProduktionDatentypen.Forschung_Enum);
      
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
