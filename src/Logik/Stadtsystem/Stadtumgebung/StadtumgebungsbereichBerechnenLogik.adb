with SystemDatentypen;
with SpeziesKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseForschungenDatenbank;

with MeldungssystemHTSEB;
with ForschungstestsLogik;

package body StadtumgebungsbereichBerechnenLogik is

   procedure StadtumgebungsbereichFestlegen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      case
        StadtSpeziesNummerExtern.Spezies
      is
         when SpeziesKonstanten.LeerSpezies =>
            -- Dieser Fall sollte niemals eintreten, muss aber mitgenommen werden wegen dem Record.
            MeldungssystemHTSEB.Logik (MeldungExtern => "StadtumgebungsbereichBerechnenLogik.StadtUmgebungsbereichFestlegen: Keine Spezies");
            
         when others =>
            StadtumgebungErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
   end StadtumgebungsbereichFestlegen;
   
   
   
   procedure StadtumgebungErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtDatentypen.Einwohner;
   begin
      
      Einwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                      EinwohnerArbeiterExtern  => True);
      
      if
        Einwohner = StadtKonstanten.LeerEinwohner
      then
         Umgebung := StadtKonstanten.LeerUmgebungGröße;
      
      elsif
        True = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                                          TechnologieExtern => LeseForschungenDatenbank.Umgebung (AnfangEndeExtern => SystemDatentypen.Endwert_Enum,
                                                                                                                  SpeziesExtern    => StadtSpeziesNummerExtern.Spezies))
        and
          Einwohner >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtSpeziesNummerExtern.Spezies)
      then
         Umgebung := GroßeStadt;
         
      elsif
        True = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                                          TechnologieExtern => LeseForschungenDatenbank.Umgebung (AnfangEndeExtern => SystemDatentypen.Anfangswert_Enum,
                                                                                                                  SpeziesExtern    => StadtSpeziesNummerExtern.Spezies))
        and
          Einwohner >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtSpeziesNummerExtern.Spezies)
      then
         Umgebung := MittlereStadt;
         
      else
         Umgebung := KleineStadt;
      end if;
      
      SchreibeStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                           UmgebungGrößeExtern    => Umgebung,
                                           ÄndernSetzenExtern     => False);
      
   end StadtumgebungErmitteln;

end StadtumgebungsbereichBerechnenLogik;
