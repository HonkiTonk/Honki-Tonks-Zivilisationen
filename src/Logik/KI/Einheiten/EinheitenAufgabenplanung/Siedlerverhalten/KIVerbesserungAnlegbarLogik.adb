with BefehleDatentypen;
with AufgabenDatentypen;

with LeseWeltkarte;
with SchreibeEinheitenGebaut;

with AufgabenLogik;

-- Bei den Verbesserungen später noch einen eventuell vorhandenen Zusatzgrund berücksichtigen? äöü
-- Sollte sinnvoll sein, genau wie eventuelle Speziesunterschiede mit einbeziehen. äöü
-- Die Reihenfolge der Verbesserungsprüfungen auch Spezienspezifisch gestalten? äöü
package body KIVerbesserungAnlegbarLogik is

   function VerbesserungAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartenextraDatentypen.Ressourcen_Enum;
   begin
      
      Ressourcen := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        Ressourcen
      is
         when KartenextraDatentypen.Hochwertiges_Holz_Enum =>
            return False;
            
         when others =>
            Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      end case;
      
      case
        MineAnlegen (KoordinatenExtern          => KoordinatenExtern,
                     EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                     BasisgrundExtern           => Basisgrund,
                     RessourceExtern            => Ressourcen)
      is
         when True =>
            return True;
            
         when False =>
            null;
      end case;
      
      case
        FestungAnlegen (KoordinatenExtern          => KoordinatenExtern,
                        EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                        BasisgrundExtern           => Basisgrund)
      is
         when True =>
            return True;
            
         when False =>
            null;
      end case;
         
      case
        FarmAnlegen (KoordinatenExtern          => KoordinatenExtern,
                     EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when True =>
            return True;
            
         when False =>
            null;
      end case;
      
      return False;
      
   end VerbesserungAnlegbar;
   
   
   
   function MineAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartenextraDatentypen.Ressourcen_Enum;
   begin
      
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => BefehleDatentypen.Mine_Bauen_Enum,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        BasisgrundExtern = KartengrundDatentypen.Hügel_Enum
        or
          BasisgrundExtern = KartengrundDatentypen.Gebirge_Enum
          or
            RessourceExtern = KartenextraDatentypen.Kohle_Enum
            or
              RessourceExtern = KartenextraDatentypen.Eisen_Enum
              or
                RessourceExtern = KartenextraDatentypen.Gold_Enum
      then
         SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                 BeschäftigungExtern        => AufgabenDatentypen.Mine_Bauen_Enum);
         return True;
               
      else
         return False;
      end if;
            
   end MineAnlegen;
   
   
   
   function FestungAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => BefehleDatentypen.Festung_Bauen_Enum,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        BasisgrundExtern = KartengrundDatentypen.Eis_Enum
      then
         SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                 BeschäftigungExtern        => AufgabenDatentypen.Festung_Bauen_Enum);
         return True;
               
      else
         return False;
      end if;
      
   end FestungAnlegen;
   
   
   
   function FarmAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => BefehleDatentypen.Farm_Bauen_Enum,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => KoordinatenExtern)
      is
         when True =>
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => AufgabenDatentypen.Farm_Bauen_Enum);
            return True;
            
         when False =>
            return False;
      end case;
      
   end FarmAnlegen;

end KIVerbesserungAnlegbarLogik;
