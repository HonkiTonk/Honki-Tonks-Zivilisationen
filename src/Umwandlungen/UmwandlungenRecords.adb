package body UmwandlungenRecords is

   function KartenfeldVorhandenNatural
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      return (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte);
      
   end KartenfeldVorhandenNatural;

end UmwandlungenRecords;
