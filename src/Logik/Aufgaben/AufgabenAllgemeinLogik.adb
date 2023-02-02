with SchreibeEinheitenGebaut;

package body AufgabenAllgemeinLogik is
   
   procedure Nullsetzung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              BeschäftigungExtern       => EinheitenKonstanten.LeerBeschäftigung);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   ZeitExtern                 => EinheitenKonstanten.LeerBeschäftigungszeit,
                                                   RechnenSetzenExtern        => False);
      
      SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        BeschäftigungExtern        => EinheitenKonstanten.LeerBeschäftigung);
      SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             ZeitExtern                 => EinheitenKonstanten.LeerBeschäftigungszeit,
                                                             RechnenSetzenExtern        => False);
      
   end Nullsetzung;

end AufgabenAllgemeinLogik;
