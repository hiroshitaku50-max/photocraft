//! Release checks through `craft-update`, the library every Craft App shares. Only public release
//! metadata is requested.

use photocraft_engine::updates_cmds::{CheckFn, CheckResult, Release};

pub fn service() -> CheckFn {
    Box::new(|| {
        let (tx, rx) = std::sync::mpsc::channel();
        std::thread::Builder::new()
            .name("update check".into())
            .spawn(move || {
                let result = check();
                if let Err(e) = &result {
                    log::warn!("Update check: {e}");
                }
                let _ = tx.send(result);
            })
            .map_err(|e| format!("Could not start update check: {e}"))?;
        Ok(rx)
    })
}

/// Nousara Image does not take upstream PhotoCraft releases: installing one would replace this
/// build (and its name and icon) with PhotoCraft. Report "up to date" until Nousara Image has a
/// release feed of its own.
fn check() -> CheckResult {
    let _: Option<Release> = None;
    Ok(None)
}
