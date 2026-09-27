with AufgabenDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with KartenfeldereffekteLogik;

package body AufgabeFestlegenLogik is

   procedure AufgabeFestlegen
     (ArbeitExtern : in EinheitenRecords.ArbeitVorleistungRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      if
        ArbeitExtern.Aufgabe = AufgabenDatentypen.Feldeffekt_Entfernen_Enum
        or
          KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)) = False
      then
         Arbeitszeit := ArbeitExtern.Arbeitszeit;
         
      else
         -- Hier kommt die Arbeitszeit zweimal rein, weil der vorhandene Feldeffekt berücksichtigt wird.
         Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => ArbeitExtern.Arbeitszeit,
                                            ZusatzwertExtern => ArbeitExtern.Arbeitszeit);
      end if;
   
      case
        ArbeitExtern.Vorarbeit
      is
         when True =>
            SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                              BeschäftigungExtern        => ArbeitExtern.Aufgabe);
            SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                   ZeitExtern                 => Arbeitszeit,
                                                                   RechnenSetzenExtern        => False);
               
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => ArbeitExtern.Aufgabe);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                         ZeitExtern                 => Arbeitszeit,
                                                         RechnenSetzenExtern        => False);
      end case;
      
   end AufgabeFestlegen;
   
   
   
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

end AufgabeFestlegenLogik;
