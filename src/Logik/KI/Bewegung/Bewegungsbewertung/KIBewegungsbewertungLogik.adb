with KartenKonstanten;

with LeseEinheitenGebaut;

with KIEbenebewertung;
with KISenkrechtebewertung;
with KIWaagerechtebewertung;

package body KIBewegungsbewertungLogik is

   function PositionsbewertungEinheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Zielkoordinaten.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartenDatentypen.SenkrechteNatural'Last;
            
         when others =>
            return PositionsbewertungKoordinaten (ZielkoordinatenExtern => Zielkoordinaten,
                                                  NeueKoordinatenExtern => NeueKoordinatenExtern);
      end case;
      
   end PositionsbewertungEinheit;
   
   
   
   function PositionsbewertungKoordinaten
     (ZielkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      BewertungEbene := KIEbenebewertung.EbeneBewerten (ZielebeneExtern => ZielkoordinatenExtern.Ebene,
                                                            NeueEbeneExtern => NeueKoordinatenExtern.Ebene);
            
      BewertungSenkrechte := KISenkrechtebewertung.SenkrechteBewerten (ZielpunktExtern  => ZielkoordinatenExtern.Senkrechte,
                                                            NeuerPunktExtern => NeueKoordinatenExtern.Senkrechte);
            
      BewertungWaagerechte := KIWaagerechtebewertung.WaagerechteBewerten (ZielpunktExtern  => ZielkoordinatenExtern.Waagerechte,
                                                            NeuerPunktExtern => NeueKoordinatenExtern.Waagerechte);
      
      if
        Natural (BewertungEbene) + Natural (BewertungSenkrechte) + Natural (BewertungWaagerechte) >= Natural (KartenDatentypen.SenkrechtePositiv'Last)
      then
         return KartenDatentypen.SenkrechtePositiv'Last;
         
      else
         return BewertungEbene + BewertungSenkrechte + KartenDatentypen.Senkrechte (BewertungWaagerechte);
      end if;
      
   end PositionsbewertungKoordinaten;

end KIBewegungsbewertungLogik;
