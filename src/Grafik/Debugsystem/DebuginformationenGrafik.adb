with SpeziesDatentypen;
with EinheitenDatentypen;
with TextaccessVariablen;

with LeseSpeziesbelegung;
with LeseEinheitenGebaut;

with TextaccessverwaltungssystemErweitertGrafik;

package body DebuginformationenGrafik is
   
   function EInheiteninformationenKI
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      case
        EinheitSpeziesNummerExtern.Spezies
      is
         when SpeziesDatentypen.Leer_Spezies_Enum =>
            return TextpositionExtern.y;
            
         when others =>
            null;
      end case;
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when SpeziesDatentypen.KI_Spieler_Enum =>
            YTextpositionDebug := TextpositionExtern.y;
      
            Koordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
            Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => "Spezies: ") & EinheitSpeziesNummerExtern.Spezies'Wide_Wide_Image & "Nr.:" & EinheitSpeziesNummerExtern.Nummer'Wide_Wide_Image;
            
            YTextpositionDebug := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => Zwischenspeicher),
                                                                                                      TextpositionExtern       => (TextpositionExtern.x, YTextpositionDebug),
                                                                                                      MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                      TextAccessExtern         => TextaccessVariablen.EinheitenseitenleisteAccess);
            
            Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => "Ziel: ") & Koordinaten.Ebene'Wide_Wide_Image & "," & Koordinaten.Senkrechte'Wide_Wide_Image & "," & Koordinaten.Waagerechte'Wide_Wide_Image;
            
            YTextpositionDebug := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => Zwischenspeicher),
                                                                                                      TextpositionExtern       => (TextpositionExtern.x, YTextpositionDebug),
                                                                                                      MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                      TextAccessExtern         => TextaccessVariablen.EinheitenseitenleisteAccess);
            
            Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => "Aufgabe: ") & LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image;
            
            YTextpositionDebug := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => Zwischenspeicher),
                                                                                                      TextpositionExtern       => (TextpositionExtern.x, YTextpositionDebug),
                                                                                                      MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                      TextAccessExtern         => TextaccessVariablen.EinheitenseitenleisteAccess);
            
         when others =>
            return TextpositionExtern.y;
      end case;
      
      PlanSchleife:
      for PlanSchleifenwert in EinheitenDatentypen.BewegungsplanVorhanden'First .. 10 loop
         
         Koordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                            PlanschrittExtern          => PlanSchleifenwert);
         
         Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => "Wegpunkt: ") & PlanSchleifenwert'Wide_Wide_Image & ":" & Koordinaten.Ebene'Wide_Wide_Image & "," & Koordinaten.Senkrechte'Wide_Wide_Image & ","
           & Koordinaten.Waagerechte'Wide_Wide_Image;
            
         YTextpositionDebug := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => Zwischenspeicher),
                                                                                                   TextpositionExtern       => (TextpositionExtern.x, YTextpositionDebug),
                                                                                                   MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                   TextAccessExtern         => TextaccessVariablen.EinheitenseitenleisteAccess);
         
      end loop PlanSchleife;
      
      return YTextpositionDebug;
      
   end EInheiteninformationenKI;

end DebuginformationenGrafik;
