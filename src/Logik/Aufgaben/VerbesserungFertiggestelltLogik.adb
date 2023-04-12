with EinheitenDatentypen;
with ProduktionDatentypen;

with KIDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with MeldungenSetzenLogik;
with AufgabeFestlegenLogik;
with WegeplatzierungssystemLogik;
with WaldAnlegenLogik;
with RodenAnlegenLogik;
with VerbesserungAnlegenLogik;
with FeldeffektEntfernenLogik;

package body VerbesserungFertiggestelltLogik is

   procedure VerbesserungFertiggestellt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type ProduktionDatentypen.Arbeitszeit;
   begin
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when EinheitenKonstanten.LeerBeschäftigung | AufgabenDatentypen.Heilen_Enum | AufgabenDatentypen.Verschanzen_Enum =>
            return;
               
         when others =>
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                         ZeitExtern                 => -1,
                                                         RechnenSetzenExtern        => True);
      end case;
      
      if
        LeseEinheitenGebaut.Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerBeschäftigungszeit
      then
         MeldungenSetzenLogik.EinheitmeldungSetzen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    EreignisExtern             => EinheitenDatentypen.Aufgabe_Abgeschlossen_Enum);
         VerbesserungAngelegt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         AufgabeNachfolgerVerschieben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
      else
         null;
      end if;
      
   end VerbesserungFertiggestellt;
   
   
   
   procedure AufgabeNachfolgerVerschieben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when EinheitenKonstanten.LeerBeschäftigung =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern             => KIDatentypen.Leer_Aufgabe_Enum);
            AufgabeFestlegenLogik.Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);

         when others =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                         ZeitExtern                 => LeseEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                         RechnenSetzenExtern        => False);
            SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                              BeschäftigungExtern        => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                   ZeitExtern                 => EinheitenKonstanten.LeerBeschäftigungszeit,
                                                                   RechnenSetzenExtern        => False);
      end case;
      
   end AufgabeNachfolgerVerschieben;



   procedure VerbesserungAngelegt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      WelcheAufgabe := LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        WelcheAufgabe
      is
         when AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range =>
            WegeplatzierungssystemLogik.Wegplatzierung (KoordinatenExtern => Koordinaten,
                                                        WegartExtern      => WelcheAufgabe);
            
         when AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum'Range =>
            VerbesserungAnlegenLogik.VerbesserungAnlegen (KoordinatenExtern  => Koordinaten,
                                                          VerbesserungExtern => WelcheAufgabe);
              
         when AufgabenDatentypen.Wald_Aufforsten_Enum =>
            WaldAnlegenLogik.WaldAnlegen (KoordinatenExtern => Koordinaten);
              
         when AufgabenDatentypen.Roden_Trockenlegen_Enum =>
            RodenAnlegenLogik.RodenAnlegen (KoordinatenExtern => Koordinaten);
            
         when AufgabenDatentypen.Feldeffekt_Entfernen_Enum =>
            FeldeffektEntfernenLogik.FeldeffektEntfernen (KoordinatenExtern => Koordinaten,
                                                          FeldeffektExtern  => WelcheAufgabe);
      end case;
      
   end VerbesserungAngelegt;

end VerbesserungFertiggestelltLogik;
