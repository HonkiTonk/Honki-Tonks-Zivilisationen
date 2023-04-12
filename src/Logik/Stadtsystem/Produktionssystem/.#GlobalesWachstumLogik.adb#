with WichtigesKonstanten;
with KartenverbesserungDatentypen;
with StadtKonstanten;

with SchreibeWichtiges;
with LeseStadtGebaut;
with LeseGrenzen;

package body GlobalesWachstumLogik is
   
   procedure WachstumsratenBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        SpeziesExtern
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            SchreibeWichtiges.GeldZugewinnProRunde (SpeziesExtern       => SpeziesExtern,
                                                    GeldZugewinnExtern  => WichtigesKonstanten.LeerGeldZugewinnProRunde,
                                                    RechnenSetzenExtern => False);
      end case;
      
      SchreibeWichtiges.GesamteForschungsrate (SpeziesExtern                => SpeziesExtern,
                                               ForschungsrateZugewinnExtern => WichtigesKonstanten.LeerGesamteForschungsrate,
                                               RechnenSetzenExtern          => False);
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               if
                 SpeziesExtern = SpeziesDatentypen.Ekropa_Enum
               then
                  null;
                  
               else
                  SchreibeWichtiges.GeldZugewinnProRunde (SpeziesExtern       => SpeziesExtern,
                                                          GeldZugewinnExtern  => LeseStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)),
                                                          RechnenSetzenExtern => True);
               end if;
               
               SchreibeWichtiges.GesamteForschungsrate (SpeziesExtern                => SpeziesExtern,
                                                        ForschungsrateZugewinnExtern => LeseStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)),
                                                        RechnenSetzenExtern          => True);
         end case;
         
      end loop StadtSchleife;
      
   end WachstumsratenBerechnen;

end GlobalesWachstumLogik;
