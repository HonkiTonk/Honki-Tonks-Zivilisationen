with WichtigesKonstanten;
with KartenverbesserungDatentypen;
with StadtKonstanten;

with SchreibeWichtiges;
with LeseStadtGebaut;
with LeseGrenzen;

package body GlobalesWachstumLogik is

   procedure WachstumWichtiges
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      case
        RasseExtern
      is
         when StadtKonstanten.LeerRasse =>
            RassenSchleife:
            for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
               case
                 SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
               is
                  when RassenDatentypen.Leer_Spieler_Enum =>
                     null;
                     
                  when others =>
                     WachstumsratenBerechnen (RasseExtern => RasseSchleifenwert);
               end case;
               
            end loop RassenSchleife;
            
         when others =>
            WachstumsratenBerechnen (RasseExtern => RasseExtern);
      end case;
      
   end WachstumWichtiges;
   
   
   
   procedure WachstumsratenBerechnen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => RasseExtern,
                                                    GeldZugewinnExtern  => WichtigesKonstanten.LeerGeldZugewinnProRunde,
                                                    RechnenSetzenExtern => False);
      end case;
      
      SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => RasseExtern,
                                               ForschungsrateZugewinnExtern => WichtigesKonstanten.LeerGesamteForschungsrate,
                                               RechnenSetzenExtern          => False);
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               if
                 RasseExtern = RassenDatentypen.Ekropa_Enum
               then
                  null;
                  
               else
                  SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => RasseExtern,
                                                          GeldZugewinnExtern  => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                                          RechnenSetzenExtern => True);
               end if;
               
               SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => RasseExtern,
                                                        ForschungsrateZugewinnExtern => LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                                        RechnenSetzenExtern          => True);
         end case;
         
      end loop StadtSchleife;
      
   end WachstumsratenBerechnen;

end GlobalesWachstumLogik;
