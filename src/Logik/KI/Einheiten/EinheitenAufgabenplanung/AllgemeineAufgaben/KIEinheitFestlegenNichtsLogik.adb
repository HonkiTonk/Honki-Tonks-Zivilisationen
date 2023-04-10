-- with KartenKonstanten;
-- with KartenDatentypen;

with SchreibeEinheitenGebaut;
-- with LeseEinheitenGebaut;

with KIDatentypen;

-- with KIAufgabenVerteiltLogik;
-- with KIZielSuchenLogik;

package body KIEinheitFestlegenNichtsLogik is

   procedure NichtsTun
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
     -- use type KartenDatentypen.Kartenfeld;
   begin
      
    --  case
    --    KIAufgabenVerteiltLogik.EinheitZiel (SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
    --                                         ZielKoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
    --  is
       --  when False =>
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              AufgabeExtern              => KIDatentypen.Platz_Machen_Enum);
      SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              BeschäftigungExtern        => EinheitenKonstanten.LeerBeschäftigung);
      --  SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
      --                                           BewegungspunkteExtern      => EinheitenKonstanten.LeerBewegungspunkte,
      --                                           RechnenSetzenExtern        => False);
            
      -- when True =>
        --    Zielkoordinaten := KIZielSuchenLogik.ZielSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
        --                                                     ZielartExtern              => KIDatentypen.Platz_Machen_Enum);
            
        --    if
        --      Zielkoordinaten.XAchse = KartenKonstanten.LeerXAchse
        --    then
        --       null;
               
        --    else
         --      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
         --                                              AufgabeExtern              => KIDatentypen.Platz_Machen_Enum);
            
         --      SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
        --                                                  KoordinatenExtern          => Zielkoordinaten);
        --    end if;
    --  end case;
      
   end NichtsTun;

end KIEinheitFestlegenNichtsLogik;
