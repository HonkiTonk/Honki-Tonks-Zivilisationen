package body Contracts is

   function Koordinatenprüfung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
        and
          KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
      then
         return True;
      
      else
         return False;
      end if;
      
   end Koordinatenprüfung;

end Contracts;
