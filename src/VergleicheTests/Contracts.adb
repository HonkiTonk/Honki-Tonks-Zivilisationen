package body Contracts is

   -- Brauche ich diese Prüfungen hier überhaupt, wenn sie schon im Contracts selsbt geprüft werden? äöü
   function Koordinatenprüfung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        KoordinatenExtern.Ebene <= LeseWeltkarteneinstellungen.EbeneEnde
        and
          KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
          and
            KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
      then
         return True;
      
      else
         return False;
      end if;
      
   end Koordinatenprüfung;
   
   
   
   function VorhandeneKoordinatenprüfung
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
      return Boolean
   is begin
      
      if
        KoordinatenExtern.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
        and
          KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
          and
            KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
      then
         return True;
      
      else
         return False;
      end if;
      
   end VorhandeneKoordinatenprüfung;

end Contracts;
