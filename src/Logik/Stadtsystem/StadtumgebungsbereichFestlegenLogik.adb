with SystemDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseForschungenDatenbank;

with Fehlermeldungssystem;
with ForschungstestsLogik;

package body StadtumgebungsbereichFestlegenLogik is

   procedure StadtumgebungsbereichFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when StadtKonstanten.LeerRasse =>
            -- Dieser Fall sollte niemals eintreten, muss aber mitgenommen werden wegen dem Record.
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "StadtUmgebungsbereichFestlegen.StadtUmgebungsbereichFestlegen: Keine Rasse ausgewählt.");
            
         when others =>
            StadtumgebungErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end StadtumgebungsbereichFestlegen;
   
   
   
   procedure StadtumgebungErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Einwohner;
   begin
      
      Einwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                      EinwohnerArbeiterExtern => True);
      
      if
        True = ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                          TechnologieExtern => LeseForschungenDatenbank.Umgebung (AnfangEndeExtern => SystemDatentypen.Endwert_Enum,
                                                                                                                  RasseExtern      => StadtRasseNummerExtern.Rasse))
        and
          Einwohner >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse)
      then
         Umgebung := 3;
         
      elsif
        True = ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                          TechnologieExtern => LeseForschungenDatenbank.Umgebung (AnfangEndeExtern => SystemDatentypen.Anfangswert_Enum,
                                                                                                                  RasseExtern      => StadtRasseNummerExtern.Rasse))
        and
          Einwohner >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse)
      then
         Umgebung := 2;      
         
      else
         Umgebung := 1;
      end if;
      
      SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           UmgebungGrößeExtern    => Umgebung,
                                           ÄndernSetzenExtern     => False);
      
   end StadtumgebungErmitteln;

end StadtumgebungsbereichFestlegenLogik;
